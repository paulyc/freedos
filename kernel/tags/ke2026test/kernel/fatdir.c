/****************************************************************/
/*                                                              */
/*                          fatdir.c                            */
/*                            DOS-C                             */
/*                                                              */
/*                 FAT File System dir Functions                */
/*                                                              */
/*                      Copyright (c) 1995                      */
/*                      Pasquale J. Villani                     */
/*                      All Rights Reserved                     */
/*                                                              */
/* This file is part of DOS-C.                                  */
/*                                                              */
/* DOS-C is free software; you can redistribute it and/or       */
/* modify it under the terms of the GNU General Public License  */
/* as published by the Free Software Foundation; either version */
/* 2, or (at your option) any later version.                    */
/*                                                              */
/* DOS-C is distributed in the hope that it will be useful, but */
/* WITHOUT ANY WARRANTY; without even the implied warranty of   */
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See    */
/* the GNU General Public License for more details.             */
/*                                                              */
/* You should have received a copy of the GNU General Public    */
/* License along with DOS-C; see the file COPYING.  If not,     */
/* write to the Free Software Foundation, 675 Mass Ave,         */
/* Cambridge, MA 02139, USA.                                    */
/****************************************************************/

#include "portab.h"
#include "globals.h"

#ifdef VERSION_STRINGS
static BYTE *fatdirRcsId =
    "$Id$";
#endif

/* Description.
 *  Initialize a fnode so that it will point to the directory with 
 *  dirstart starting cluster; in case of passing dirstart == 0
 *  fnode will point to the start of a root directory */
VOID dir_init_fnode(f_node_ptr fnp, CLUSTER dirstart)
{
  /* reset the directory flags    */
  fnp->f_flags.f_dmod = FALSE;
  fnp->f_flags.f_droot = FALSE;
  fnp->f_flags.f_ddir = TRUE;
  fnp->f_flags.f_dnew = TRUE;
  fnp->f_diroff = fnp->f_offset = fnp->f_cluster_offset =
      fnp->f_highwater = 0l;

  /* root directory */
  if (dirstart == 0)
  {
#ifdef WITHFAT32
    if (ISFAT32(fnp->f_dpb))
    {
      fnp->f_cluster = fnp->f_dirstart = fnp->f_dpb->dpb_xrootclst;
    }
    else
#endif
    {
      fnp->f_dirstart = 0l;
      fnp->f_flags.f_droot = TRUE;
    }
  }
  else                          /* non-root */
    fnp->f_cluster = fnp->f_dirstart = dirstart;
}

f_node_ptr dir_open(BYTE * dirname)
{
  f_node_ptr fnp;
  COUNT drive;
  BYTE *p;
  WORD i;
  struct cds FAR *cdsp;
  BYTE *pszPath = dirname + 2;

  /* Allocate an fnode if possible - error return (0) if not.     */
  if ((fnp = get_f_node()) == (f_node_ptr) 0)
  {
    return (f_node_ptr) 0;
  }

  /* Force the fnode into read-write mode                         */
  fnp->f_mode = RDWR;

  /* determine what drive we are using...                         */
  if (ParseDosName
      (dirname, &drive, (BYTE *) 0, (BYTE *) 0, (BYTE *) 0,
       FALSE) != SUCCESS)
  {
    release_f_node(fnp);
    return NULL;
  }

  /* If the drive was specified, drive is non-negative and        */
  /* corresponds to the one passed in, i.e., 0 = A, 1 = B, etc.   */
  /* We use that and skip the "D:" part of the string.            */
  /* Otherwise, just use the default drive                        */
  if (drive >= 0)
  {
    dirname += 2;               /* Assume FAT style drive       */
  }
  else
  {
    drive = default_drive;
  }
  if (drive >= lastdrive)
  {
    release_f_node(fnp);
    return NULL;
  }

  cdsp = &CDSp->cds_table[drive];

  /* Generate full path name                                      */
  /* not necessary anymore, since truename did that already
     i = cdsp->cdsJoinOffset;
     ParseDosPath(dirname, (COUNT *) 0, pszPath, (BYTE FAR *) & cdsp->cdsCurrentPath[i]); */

/* for testing only for now */
#if 0
  if ((cdsp->cdsFlags & CDSNETWDRV))
  {
    printf("FailSafe %x \n", Int21AX);
    return fnp;
  }
#endif

  if (cdsp->cdsDpb == 0)
  {
    release_f_node(fnp);
    return NULL;
  }

  fnp->f_dpb = cdsp->cdsDpb;

  /* Perform all directory common handling after all special      */
  /* handling has been performed.                                 */

  if (media_check(fnp->f_dpb) < 0)
  {
    release_f_node(fnp);
    return (f_node_ptr) 0;
  }

  /* Walk the directory tree to find the starting cluster         */
  /*                                                              */
  /* Start from the root directory (dirstart = 0)                 */

  dir_init_fnode(fnp, 0);

  for (p = pszPath; *p != '\0';)
  {
    /* skip all path seperators                             */
    while (*p == '\\')
      ++p;
    /* don't continue if we're at the end                   */
    if (*p == '\0')
      break;

    /* Convert the name into an absolute name for           */
    /* comparison...                                        */
    /* first the file name with trailing spaces...          */

    memset(TempBuffer, ' ', FNAME_SIZE + FEXT_SIZE);

    for (i = 0; i < FNAME_SIZE; i++)
    {
      if (*p != '\0' && *p != '.' && *p != '/' && *p != '\\')
        TempBuffer[i] = *p++;
      else
        break;
    }

    /* and the extension (don't forget to   */
    /* add trailing spaces)...              */
    if (*p == '.')
      ++p;
    for (i = 0; i < FEXT_SIZE; i++)
    {
      if (*p != '\0' && *p != '.' && *p != '/' && *p != '\\')
        TempBuffer[i + FNAME_SIZE] = *p++;
      else
        break;
    }

    /* Now search through the directory to  */
    /* find the entry...                    */
    i = FALSE;

    DosUpFMem((BYTE FAR *) TempBuffer, FNAME_SIZE + FEXT_SIZE);

    while (dir_read(fnp) == 1)
    {
      if (fnp->f_dir.dir_name[0] != '\0'
          && fnp->f_dir.dir_name[0] != DELETED
          && !(fnp->f_dir.dir_attrib & D_VOLID))
      {
        if (fcmp
            (TempBuffer, (BYTE *) fnp->f_dir.dir_name,
             FNAME_SIZE + FEXT_SIZE))
        {
          i = TRUE;
          break;
        }
      }
    }

    if (!i || !(fnp->f_dir.dir_attrib & D_DIR))
    {

      release_f_node(fnp);
      return (f_node_ptr) 0;
    }
    else
    {
      /* make certain we've moved off */
      /* root                         */
      dir_init_fnode(fnp, getdstart(fnp->f_dir));
    }
  }
  return fnp;
}

/* Description.
 *  Read next consequitive directory entry, pointed by fnp.
 *  If some error occures the other critical
 *  fields aren't changed, except those used for caching.
 *  The fnp->f_diroff always corresponds to the directory entry
 *  which has been read.
 * Return value.
 *  1              - all OK, directory entry having been read is not empty.
 *  0              - Directory entry is empty.
 *  DE_SEEK        - Attempt to read beyound the end of the directory.
 *  DE_BLKINVLD    - Invalid block.
 * Note. Empty directory entries always resides at the end of the directory. */
COUNT dir_read(REG f_node_ptr fnp)
{
  struct buffer FAR *bp;
  REG UWORD secsize = fnp->f_dpb->dpb_secsize;
  ULONG new_diroff = fnp->f_diroff;

  /* Directories need to point to their current offset, not for   */
  /* next op. Therefore, if it is anything other than the first   */
  /* directory entry, we will update the offset on entry rather   */
  /* than wait until exit. If it was new, clear the special new   */
  /* flag.                                                        */
  if (!fnp->f_flags.f_dnew)
    new_diroff += DIRENT_SIZE;

  /* Determine if we hit the end of the directory. If we have,    */
  /* bump the offset back to the end and exit. If not, fill the   */
  /* dirent portion of the fnode, clear the f_dmod bit and leave, */
  /* but only for root directories                                */

  if (fnp->f_flags.f_droot)
  {
    if (new_diroff >= DIRENT_SIZE * (ULONG) fnp->f_dpb->dpb_dirents)
      return DE_SEEK;

    bp = getblock((ULONG) (new_diroff / secsize
                           + fnp->f_dpb->dpb_dirstrt),
                  fnp->f_dpb->dpb_unit);
#ifdef DISPLAY_GETBLOCK
    printf("DIR (dir_read)\n");
#endif
  }
  else
  {
    /* Do a "seek" to the directory position        */
    fnp->f_offset = new_diroff;

    /* Search through the FAT to find the block     */
    /* that this entry is in.                       */
#ifdef DISPLAY_GETBLOCK
    printf("dir_read: ");
#endif
    if (map_cluster(fnp, XFR_READ) != SUCCESS)
      return DE_SEEK;

    /* Compute the block within the cluster and the */
    /* offset within the block.                     */
    fnp->f_sector = (fnp->f_offset / secsize) & fnp->f_dpb->dpb_clsmask;
    fnp->f_boff = fnp->f_offset % secsize;

    /* Get the block we need from cache             */
    bp = getblock(clus2phys(fnp->f_cluster, fnp->f_dpb) + fnp->f_sector,
                  fnp->f_dpb->dpb_unit);
#ifdef DISPLAY_GETBLOCK
    printf("DIR (dir_read)\n");
#endif
  }

  /* Now that we have the block for our entry, get the    */
  /* directory entry.                                     */
  if (bp == NULL)
    return DE_BLKINVLD;

  bp->b_flag &= ~(BFR_DATA | BFR_FAT);
  bp->b_flag |= BFR_DIR | BFR_VALID;

  getdirent((BYTE FAR *) & bp->
            b_buffer[((UWORD) new_diroff) % fnp->f_dpb->dpb_secsize],
            (struct dirent FAR *)&fnp->f_dir);

  /* Update the fnode's directory info                    */
  fnp->f_flags.f_dmod = FALSE;
  fnp->f_flags.f_dnew = FALSE;
  fnp->f_diroff = new_diroff;

  /* and for efficiency, stop when we hit the first       */
  /* unused entry.                                        */
  /* either returns 1 or 0                                */
  return (fnp->f_dir.dir_name[0] != '\0');
}

/* Description.
 *  Writes directory entry pointed by fnp to disk. In case of erroneous
 *  situation fnode is released.
 *  The caller should set
 *    1. f_dmod flag if original directory entry was modified.
 *    2. f_dmod & f_dnew flags if new directory entry is created. In this
 *       case the reserved fields is cleared, but only if new dentry isn't
 *       a LFN entry (has D_LFN attribute). 
 * Return value.
 *  TRUE  - all OK.
 *  FALSE - error occured (fnode is released).
 */
#ifndef IPL
BOOL dir_write(REG f_node_ptr fnp)
{
  struct buffer FAR *bp;
  REG UWORD secsize = fnp->f_dpb->dpb_secsize;

  /* Update the entry if it was modified by a write or create...  */
  if (fnp->f_flags.f_dmod)
  {
    /* Root is a consecutive set of blocks, so handling is  */
    /* simple.                                              */
    if (fnp->f_flags.f_droot)
    {
      bp = getblock((ULONG) ((UWORD) fnp->f_diroff / secsize
                             + fnp->f_dpb->dpb_dirstrt),
                    fnp->f_dpb->dpb_unit);
#ifdef DISPLAY_GETBLOCK
      printf("DIR (dir_write)\n");
#endif
    }

    /* All other directories are just files. The only       */
    /* special handling is resetting the offset so that we  */
    /* can continually update the same directory entry.     */
    else
    {

      /* Do a "seek" to the directory position        */
      /* and convert the fnode to a directory fnode.  */
      fnp->f_offset = fnp->f_diroff;
      fnp->f_back = LONG_LAST_CLUSTER;
      fnp->f_cluster = fnp->f_dirstart;
      fnp->f_cluster_offset = 0l;       /*JPP */

      /* Search through the FAT to find the block     */
      /* that this entry is in.                       */
#ifdef DISPLAY_GETBLOCK
      printf("dir_write: ");
#endif
      if (map_cluster(fnp, XFR_READ) != SUCCESS)
      {
        release_f_node(fnp);
        return FALSE;
      }

      /* Compute the block within the cluster and the */
      /* offset within the block.                     */
      fnp->f_sector = (fnp->f_offset / secsize) & fnp->f_dpb->dpb_clsmask;
      fnp->f_boff = fnp->f_offset % secsize;

      /* Get the block we need from cache             */
      bp = getblock(clus2phys(fnp->f_cluster, fnp->f_dpb) + fnp->f_sector,
                    fnp->f_dpb->dpb_unit);
      bp->b_flag &= ~(BFR_DATA | BFR_FAT);
      bp->b_flag |= BFR_DIR | BFR_VALID;
#ifdef DISPLAY_GETBLOCK
      printf("DIR (dir_write)\n");
#endif
    }

    /* Now that we have a block, transfer the directory      */
    /* entry into the block.                                */
    if (bp == NULL)
    {
      release_f_node(fnp);
      return FALSE;
    }

    if (fnp->f_flags.f_dnew && fnp->f_dir.dir_attrib != D_LFN)
      fmemset(&fnp->f_dir.dir_case, 0, 8);
    putdirent((struct dirent FAR *)&fnp->f_dir,
              (VOID FAR *) & bp->b_buffer[(UWORD) fnp->f_diroff %
                                          fnp->f_dpb->dpb_secsize]);

    bp->b_flag &= ~(BFR_DATA | BFR_FAT);
    bp->b_flag |= BFR_DIR | BFR_DIRTY | BFR_VALID;
  }
  return TRUE;
}
#endif

VOID dir_close(REG f_node_ptr fnp)
{
  /* Test for invalid f_nodes                                     */
  if (fnp == NULL)
    return;

#ifndef IPL
  /* Write out the entry                                          */
  dir_write(fnp);

#endif
  /* Clear buffers after release                                  */
  flush_buffers(fnp->f_dpb->dpb_unit);

  /* and release this instance of the fnode                       */
  release_f_node(fnp);
}

#ifndef IPL
COUNT dos_findfirst(UCOUNT attr, BYTE * name)
{
  REG f_node_ptr fnp;
  REG dmatch *dmp = (dmatch *) TempBuffer;
  REG COUNT i;
  COUNT nDrive;
  BYTE *p;

  BYTE local_name[FNAME_SIZE + 1], local_ext[FEXT_SIZE + 1];

/*  printf("ff %Fs\n", name);*/

  /* The findfirst/findnext calls are probably the worst of the   */
  /* DOS calls. They must work somewhat on the fly (i.e. - open   */
  /* but never close). Since we don't want to lose fnodes every   */
  /* time a directory is searched, we will initialize the DOS     */
  /* dirmatch structure and then for every find, we will open the */
  /* current directory, do a seek and read, then close the fnode. */

  /* Parse out the drive, file name and file extension.           */
  i = ParseDosName(name, &nDrive, &szDirName[2], local_name, local_ext,
                   TRUE);
  if (i != SUCCESS)
    return i;
/*
  printf("\nff %s", Tname);
  printf("ff %s", local_name);
  printf("ff %s\n", local_ext);
*/

  /* Build the match pattern out of the passed string             */
  /* copy the part of the pattern which belongs to the filename and is fixed */
  for (p = local_name, i = 0; i < FNAME_SIZE && *p; ++p, ++i)
    SearchDir.dir_name[i] = *p;

  for (; i < FNAME_SIZE; ++i)
    SearchDir.dir_name[i] = ' ';

  /* and the extension (don't forget to add trailing spaces)...   */
  for (p = local_ext, i = 0; i < FEXT_SIZE && *p; ++p, ++i)
    SearchDir.dir_ext[i] = *p;

  for (; i < FEXT_SIZE; ++i)
    SearchDir.dir_ext[i] = ' ';

  /* Convert everything to uppercase. */
  DosUpFMem(SearchDir.dir_name, FNAME_SIZE + FEXT_SIZE);

  /* Now search through the directory to find the entry...        */

  /* Complete building the directory from the passed in   */
  /* name                                                 */
  szDirName[0] = 'A' + nDrive;
  szDirName[1] = ':';

  /* Special handling - the volume id is only in the root         */
  /* directory and only searched for once.  So we need to open    */
  /* the root and return only the first entry that contains the   */
  /* volume id bit set.                                           */
  if (attr == D_VOLID)
  {
    szDirName[2] = '\\';
    szDirName[3] = '\0';
  }
  /* Now open this directory so that we can read the      */
  /* fnode entry and do a match on it.                    */

/*  printf("dir_open %s\n", szDirName);*/
  if ((fnp = dir_open(szDirName)) == NULL)
    return DE_PATHNOTFND;

  /* Now initialize the dirmatch structure.            */

  nDrive = get_verify_drive(name);
  if (nDrive < 0)
    return nDrive;
  dmp->dm_drive = nDrive;
  dmp->dm_attr_srch = attr;

  /* Copy the raw pattern from our data segment to the DTA. */
  fmemcpy(dmp->dm_name_pat, SearchDir.dir_name, FNAME_SIZE + FEXT_SIZE);

  if (attr == D_VOLID)
  {
    /* Now do the search                                    */
    while (dir_read(fnp) == 1)
    {
      /* Test the attribute and return first found    */
      if ((fnp->f_dir.dir_attrib & ~(D_RDONLY | D_ARCHIVE)) == D_VOLID)
      {
        dmp->dm_dircluster = fnp->f_dirstart;   /* TE */
        memcpy(&SearchDir, &fnp->f_dir, sizeof(struct dirent));
#ifdef DEBUG
        printf("dos_findfirst: %11s\n", fnp->f_dir.dir_name);
#endif
        dir_close(fnp);
        return SUCCESS;
      }
    }

    /* Now that we've done our failed search, close it and  */
    /* return an error.                                     */
    dir_close(fnp);
    return DE_FILENOTFND;
  }
  /* Otherwise just do a normal find next                         */
  else
  {
    dmp->dm_entry = 0;
    if (!fnp->f_flags.f_droot)
      dmp->dm_dircluster = fnp->f_dirstart;
    else
      dmp->dm_dircluster = 0;
    dir_close(fnp);
    return dos_findnext();
  }
}

/*
    BUGFIX TE 06/28/01 
    
    when using FcbFindXxx, the only information available is
    the cluster number + entrycount. everything else MUST\
    be recalculated. 
    a good test for this is MSDOS CHKDSK, which now (seems too) work
*/

COUNT dos_findnext(void)
{
  REG dmatch *dmp = (dmatch *) TempBuffer;
  REG f_node_ptr fnp;
  BOOL found = FALSE;

  /* Allocate an fnode if possible - error return (0) if not.     */
  if ((fnp = get_f_node()) == (f_node_ptr) 0)
  {
    return DE_NFILES;
  }

  memset(fnp, 0, sizeof(*fnp));

  /* Force the fnode into read-write mode                         */
  fnp->f_mode = RDWR;

  /* Select the default to help non-drive specified path          */
  /* searches...                                                  */
  fnp->f_dpb = CDSp->cds_table[dmp->dm_drive].cdsDpb;
  if (media_check(fnp->f_dpb) < 0)
  {
    release_f_node(fnp);
    return DE_NFILES;
  }

  dir_init_fnode(fnp, dmp->dm_dircluster);

  /* Search through the directory to find the entry, but do a     */
  /* seek first.                                                  */
  if (dmp->dm_entry > 0)
  {
    fnp->f_diroff = (ULONG) (dmp->dm_entry - 1) * DIRENT_SIZE;
    fnp->f_flags.f_dnew = FALSE;
  }
  else
  {
    fnp->f_diroff = 0;
    fnp->f_flags.f_dnew = TRUE;
  }

  /* Loop through the directory                                   */
  while (dir_read(fnp) == 1)
  {
    ++dmp->dm_entry;
    if (fnp->f_dir.dir_name[0] != '\0' && fnp->f_dir.dir_name[0] != DELETED
        && (fnp->f_dir.dir_attrib & D_VOLID) != D_VOLID)
    {
      if (fcmp_wild
          ((BYTE FAR *) dmp->dm_name_pat, (BYTE FAR *) fnp->f_dir.dir_name,
           FNAME_SIZE + FEXT_SIZE))
      {
        /*
           MSD Command.com uses FCB FN 11 & 12 with attrib set to 0x16.
           Bits 0x21 seem to get set some where in MSD so Rd and Arc
           files are returned. 
           RdOnly + Archive bits are ignored
         */

        /* Test the attribute as the final step */
        if (!(fnp->f_dir.dir_attrib & D_VOLID) &&
            ((~dmp->dm_attr_srch & fnp->f_dir.
              dir_attrib & (D_DIR | D_SYSTEM | D_HIDDEN)) == 0))
        {
          found = TRUE;
          break;
        }
        else
          continue;
      }
    }
  }

  /* If found, transfer it to the dmatch structure                */
  if (found)
  {
    dmp->dm_dircluster = fnp->f_dirstart;
    memcpy(&SearchDir, &fnp->f_dir, sizeof(struct dirent));
  }

#ifdef DEBUG
  printf("dos_findnext: %11s\n", fnp->f_dir.dir_name);
#endif
  /* return the result                                            */
  release_f_node(fnp);

  return found ? SUCCESS : DE_NFILES;
}
#endif
/*
    this receives a name in 11 char field NAME+EXT and builds 
    a zeroterminated string

    unfortunately, blanks are allowed in filenames. like 
        "test e", " test .y z",...
        
    so we have to work from the last blank backward 
*/
void ConvertName83ToNameSZ(BYTE FAR * destSZ, BYTE FAR * srcFCBName)
{
  int loop;
  int noExtension = FALSE;

  if (*srcFCBName == '.')
  {
    noExtension = TRUE;
  }

  fmemcpy(destSZ, srcFCBName, FNAME_SIZE);

  srcFCBName += FNAME_SIZE;

  for (loop = FNAME_SIZE; --loop >= 0;)
  {
    if (destSZ[loop] != ' ')
      break;
  }
  destSZ += loop + 1;

  if (!noExtension)             /* not for ".", ".." */
  {

    for (loop = FEXT_SIZE; --loop >= 0;)
    {
      if (srcFCBName[loop] != ' ')
        break;
    }
    if (loop >= 0)
    {
      *destSZ++ = '.';
      fmemcpy(destSZ, srcFCBName, loop + 1);
      destSZ += loop + 1;
    }
  }
  *destSZ = '\0';
}

/*
    returns the asciiSZ length of a 8.3 filename
*/

int FileName83Length(BYTE * filename83)
{
  BYTE buff[13];

  ConvertName83ToNameSZ(buff, filename83);

  return strlen(buff);
}

/*
 * Log: fatdir.c,v - for newer log entries do a "cvs log fatdir.c"
 *
 * Revision 1.12  2000/03/31 05:40:09  jtabor
 * Added Eric W. Biederman Patches
 *
 * Revision 1.11  2000/03/17 22:59:04  kernel
 * Steffen Kaiser's NLS changes
 *
 * Revision 1.10  2000/03/09 06:07:11  kernel
 * 2017f updates by James Tabor
 *
 * Revision 1.9  1999/08/25 03:18:07  jprice
 * ror4 patches to allow TC 2.01 compile.
 *
 * Revision 1.8  1999/08/10 17:57:12  jprice
 * ror4 2011-02 patch
 *
 * Revision 1.7  1999/05/03 06:25:45  jprice
 * Patches from ror4 and many changed of signed to unsigned variables.
 *
 * Revision 1.6  1999/04/16 00:53:32  jprice
 * Optimized FAT handling
 *
 * Revision 1.5  1999/04/13 15:48:20  jprice
 * no message
 *
 * Revision 1.4  1999/04/11 04:33:38  jprice
 * ror4 patches
 *
 * Revision 1.2  1999/04/04 18:51:43  jprice
 * no message
 *
 * Revision 1.1.1.1  1999/03/29 15:41:58  jprice
 * New version without IPL.SYS
 *
 * Revision 1.7  1999/03/25 05:06:57  jprice
 * Fixed findfirst & findnext functions to treat the attributes like MSDOS does.
 *
 * Revision 1.6  1999/02/14 04:27:09  jprice
 * Changed check media so that it checks if a floppy disk has been changed.
 *
 * Revision 1.5  1999/02/09 02:54:23  jprice
 * Added Pat's 1937 kernel patches
 *
 * Revision 1.4  1999/02/01 01:43:28  jprice
 * Fixed findfirst function to find volume label with Windows long filenames
 *
 * Revision 1.3  1999/01/30 08:25:34  jprice
 * Clean up; Fixed bug with set attribute function.  If you tried to
 * change the attributres of a directory, it would erase it.
 *
 * Revision 1.2  1999/01/22 04:15:28  jprice
 * Formating
 *
 * Revision 1.1.1.1  1999/01/20 05:51:00  jprice
 * Imported sources
 *
 *
 *    Rev 1.10   06 Dec 1998  8:44:36   patv
 * Bug fixes.
 *
 *    Rev 1.9   22 Jan 1998  4:09:00   patv
 * Fixed pointer problems affecting SDA
 *
 *    Rev 1.8   04 Jan 1998 23:14:36   patv
 * Changed Log for strip utility
 *
 *    Rev 1.7   03 Jan 1998  8:36:02   patv
 * Converted data area to SDA format
 *
 *    Rev 1.6   16 Jan 1997 12:46:30   patv
 * pre-Release 0.92 feature additions
 *
 *    Rev 1.5   29 May 1996 21:15:18   patv
 * bug fixes for v0.91a
 *
 *    Rev 1.4   19 Feb 1996  3:20:12   patv
 * Added NLS, int2f and config.sys processing
 *
 *    Rev 1.2   01 Sep 1995 17:48:38   patv
 * First GPL release.
 *
 *    Rev 1.1   30 Jul 1995 20:50:24   patv
 * Eliminated version strings in ipl
 *
 *    Rev 1.0   02 Jul 1995  8:04:34   patv
 * Initial revision.
 */
