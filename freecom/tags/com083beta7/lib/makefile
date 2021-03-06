# $Id$
#
# Makefile for the FreeCOM library
#
# $Log$
# Revision 1.1  2001/04/12 00:33:53  skaus
# chg: new structure
# chg: If DEBUG enabled, no available commands are displayed on startup
# fix: PTCHSIZE also patches min extra size to force to have this amount
#    of memory available on start
# bugfix: CALL doesn't reset options
# add: PTCHSIZE to patch heap size
# add: VSPAWN, /SWAP switch, .SWP resource handling
# bugfix: COMMAND.COM A:\
# bugfix: CALL: if swapOnExec == ERROR, no change of swapOnExec allowed
# add: command MEMORY
# bugfix: runExtension(): destroys command[-2]
# add: clean.bat
# add: localized CRITER strings
# chg: use LNG files for hard-coded strings (hangForEver(), init.c)
# 	via STRINGS.LIB
# add: DEL.C, COPY.C, CBREAK.C: STRINGS-based prompts
# add: fixstrs.c: prompts & symbolic keys
# add: fixstrs.c: backslash escape sequences
# add: version IDs to DEFAULT.LNG and validation to FIXSTRS.C
# chg: splitted code apart into LIB\*.c and CMD\*.c
# bugfix: IF is now using error system & STRINGS to report errors
# add: CALL: /N
#
#

MAXLINELENGTH !:= 4096

.INCLUDE : ../_config.mk

# Sources of this make target
SRC = alprmblk.c alsysblk.c beep_l.c beep_n.c brk_get.c brk_set.c cbreak.c \
	cbs.c cd_dir.c cgetch.c cgettime.c chgctxt.c chgdrv.c chgenv.c chgenvc.c \
	chgenvr.c clrline.c cmdinput.c comfile.c compfile.c ctxt.c ctxt_adr.c \
	ctxt_as.c ctxt_chg.c ctxt_clr.c ctxt_get.c ctxt_inf.c ctxt_mk.c \
	ctxt_mkn.c ctxt_pop.c ctxt_psh.c ctxt_rnu.c ctxt_set.c ctxt_ss.c \
	ctxt_vw.c curdatel.c curtime.c cwd.c dateget.c dateset.c dbg_c.c \
	dbg_mem.c dbg_prnt.c dbg_s.c dbg_sn.c devopen.c dispcnt.c drvnum.c \
	err1.c err10.c err11.c err12.c err13.c err14.c err15.c err16.c err17.c \
	err18.c err19.c err2.c err20.c err21.c err22.c err23.c err24.c err25.c \
	err26.c err27.c err28.c err29.c err3.c err30.c err31.c err32.c err33.c \
	err34.c err35.c err36.c err37.c err38.c err39.c err4.c err40.c err41.c \
	err42.c err43.c err45.c err46.c err47.c err48.c err49.c err5.c err50.c \
	err51.c err52.c err53.c err54.c err55.c err56.c err57.c err58.c err59.c \
	err6.c err60.c err61.c err62.c err63.c err64.c err65.c err66.c err7.c \
	err8.c err9.c exec.c exec1.c farread.c fcompl1.c fcompl2.c fdattr.c \
	fdevopen.c fillcomp.c find.c freep.c frsysblk.c fstpcpy.c gallstr.c \
	get1mcb.c getenv.c goxy.c grabfcom.c gumblink.c hdlrctxt.c hist_get.c \
	hist_set.c inputdos.c is_empty.c is_fnamc.c is_fnstr.c is_pchr.c \
	isadev.c keyprsd.c lastdget.c lastdset.c leadopt.c lowexec.asm ltrim.c \
	lwr1wd.c match.c messages.c mk_rddir.c mktmpfil.c msg_dflt.c msg_dps.c \
	msg_fstr.c msg_get.c msg_gpt.c msg_mkey.c msg_prmp.c mux_ae.c nls.c \
	nls_date.c nls_time.c num_fmt.c onoff.c openf.c optsb.c optsi.c optss.c \
	parsenum.c pr_date.c pr_prmpt.c pr_time.c prprompt.c realnum.c res.c \
	res_r.c res_w.c resfile.c rmtmpfil.c rtrim.c salloc.c samefile.c \
	scancmd.c scanopt.c showcmds.c skqwd.c split.c sumblink.c tempfile.c \
	timeget.c timeset.c tmpnam.c trim.c txtlend.c unquote.c vcgetch.c \
	vcgetstr.c where.c
OBJ = alprmblk.obj alsysblk.obj beep_l.obj beep_n.obj brk_get.obj \
	brk_set.obj cbreak.obj cbs.obj cd_dir.obj cgetch.obj cgettime.obj \
	chgctxt.obj chgdrv.obj chgenv.obj chgenvc.obj chgenvr.obj clrline.obj \
	cmdinput.obj comfile.obj compfile.obj ctxt.obj ctxt_adr.obj ctxt_as.obj \
	ctxt_chg.obj ctxt_clr.obj ctxt_get.obj ctxt_inf.obj ctxt_mk.obj \
	ctxt_mkn.obj ctxt_pop.obj ctxt_psh.obj ctxt_rnu.obj ctxt_set.obj \
	ctxt_ss.obj ctxt_vw.obj curdatel.obj curtime.obj cwd.obj dateget.obj \
	dateset.obj dbg_c.obj dbg_mem.obj dbg_prnt.obj dbg_s.obj dbg_sn.obj \
	devopen.obj dispcnt.obj drvnum.obj err1.obj err10.obj err11.obj \
	err12.obj err13.obj err14.obj err15.obj err16.obj err17.obj err18.obj \
	err19.obj err2.obj err20.obj err21.obj err22.obj err23.obj err24.obj \
	err25.obj err26.obj err27.obj err28.obj err29.obj err3.obj err30.obj \
	err31.obj err32.obj err33.obj err34.obj err35.obj err36.obj err37.obj \
	err38.obj err39.obj err4.obj err40.obj err41.obj err42.obj err43.obj \
	err45.obj err46.obj err47.obj err48.obj err49.obj err5.obj err50.obj \
	err51.obj err52.obj err53.obj err54.obj err55.obj err56.obj err57.obj \
	err58.obj err59.obj err6.obj err60.obj err61.obj err62.obj err63.obj \
	err64.obj err65.obj err66.obj err7.obj err8.obj err9.obj exec.obj \
	exec1.obj farread.obj fcompl1.obj fcompl2.obj fdattr.obj fdevopen.obj \
	fillcomp.obj find.obj freep.obj frsysblk.obj fstpcpy.obj gallstr.obj \
	get1mcb.obj getenv.obj goxy.obj grabfcom.obj gumblink.obj hdlrctxt.obj \
	hist_get.obj hist_set.obj inputdos.obj is_empty.obj is_fnamc.obj \
	is_fnstr.obj is_pchr.obj isadev.obj keyprsd.obj lastdget.obj \
	lastdset.obj leadopt.obj lowexec.obj ltrim.obj lwr1wd.obj match.obj \
	messages.obj mk_rddir.obj mktmpfil.obj msg_dflt.obj msg_dps.obj \
	msg_fstr.obj msg_get.obj msg_gpt.obj msg_mkey.obj msg_prmp.obj \
	mux_ae.obj nls.obj nls_date.obj nls_time.obj num_fmt.obj onoff.obj \
	openf.obj optsb.obj optsi.obj optss.obj parsenum.obj pr_date.obj \
	pr_prmpt.obj pr_time.obj prprompt.obj realnum.obj res.obj res_r.obj \
	res_w.obj resfile.obj rmtmpfil.obj rtrim.obj salloc.obj samefile.obj \
	scancmd.obj scanopt.obj showcmds.obj skqwd.obj split.obj sumblink.obj \
	tempfile.obj timeget.obj timeset.obj tmpnam.obj trim.obj txtlend.obj \
	unquote.obj vcgetch.obj vcgetstr.obj where.obj
HDR = ..\config.h ..\context.h_c ..\err_fcts.h ..\include/batch.h \
	..\include/cmdline.h ..\include/command.h ..\include/context.h \
	..\include/crossjmp.h ..\include/datefunc.h ..\include/debug.h \
	..\include/keys.h ..\include/kswap.h ..\include/misc.h \
	..\include/mux_ae.h ..\include/nls.h ..\include/openf.h ..\include/res.h \
	..\include/resource.h ..\include/strings.typ ..\include/timefunc.h \
	..\include\large.inc ..\include\model.inc ..\include\small.inc \
	..\include\stuff.inc


#	Default target
all: freecom.lib

dist : lib.mak

%.obj : %.asm ; $(NASM) $(NASMFLAGS) -f obj -F borland -o $@ $< >>errlist

### Utils are required by build process
.INIT .PHONY .SEQUENTIAL : verscheck $(CFG) __errl

.IF $(THISMAKE) == $(LASTMAKE)
verscheck :;
.ELSE
verscheck : 
	@+-echo Changed Make parameters, already made files invalid!
	+-echo LASTMAKE = $(THISMAKE) >lastmake.mk
	$(RUNMAKE) clobber
.IF $(CFG)
	$(RUNMAKE) $(CFG)
.ENDIF
.ENDIF

__errl:
	@+-if exist errlist del errlist >nul
	-ctags *.c ..\cmd\*.c ..\shell\*.c $(FREEDOS)\SRC\LIB\SUPPL\*.c

freecom.lib .LIBRARY : $(OBJ)

#MAKEDEP START
onoff.obj : onoff.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
lastdget.obj : lastdget.c \
	 ../config.h ../err_fcts.h ../include/context.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
gumblink.obj : gumblink.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
pr_date.obj : pr_date.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/nls.h \
	../include/timefunc.h
find.obj : find.c \
	 ../config.h ../include/cmdline.h ../include/debug.h
ctxt_clr.obj : ctxt_clr.c \
	 ../config.h ../include/context.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
ctxt.obj : ctxt.c \
	 ../config.h ../include/context.h ../include/debug.h
lastdset.obj : lastdset.c \
	 ../config.h ../err_fcts.h ../include/context.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
beep_l.obj : beep_l.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
is_fnstr.obj : is_fnstr.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
ctxt_ss.obj : ctxt_ss.c \
	 ../config.h ../include/context.h ../include/debug.h
cbreak.obj : cbreak.c \
	 ../config.h ../include/batch.h ../include/command.h \
	../include/datefunc.h ../include/debug.h ../include/misc.h \
	../include/timefunc.h ../strings.h
getenv.obj : getenv.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
beep_n.obj : beep_n.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
res.obj : res.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/resource.h \
	../include/timefunc.h
parsenum.obj : parsenum.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
err40.obj : err40.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err42.obj : err42.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
dbg_prnt.obj : dbg_prnt.c \
	 ../config.h ../include/debug.h
fcompl2.obj : fcompl2.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err46.obj : err46.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err48.obj : err48.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
hist_get.obj : hist_get.c \
	 ../config.h ../include/context.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
fdevopen.obj : fdevopen.c \
	 ../include/openf.h
ctxt_rnu.obj : ctxt_rnu.c \
	 ../config.h ../include/command.h ../include/context.h \
	../include/datefunc.h ../include/debug.h ../include/misc.h \
	../include/timefunc.h
chgenv.obj : chgenv.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
drvnum.obj : drvnum.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
mux_ae.obj : mux_ae.c \
	 ../config.h ../include/command.h ../include/crossjmp.h \
	../include/datefunc.h ../include/debug.h ../include/misc.h \
	../include/mux_ae.h ../include/timefunc.h
comfile.obj : comfile.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
hist_set.obj : hist_set.c \
	 ../config.h ../include/context.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
get1mcb.obj : get1mcb.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
msg_prmp.obj : msg_prmp.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
cd_dir.obj : cd_dir.c \
	 ../config.h ../err_fcts.h ../include/cmdline.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err10.obj : err10.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
dbg_mem.obj : dbg_mem.c \
	 ../config.h ../include/debug.h
err12.obj : err12.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
hdlrctxt.obj : hdlrctxt.c \
	 ../config.h ../err_fcts.h ../include/context.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
ctxt_psh.obj : ctxt_psh.c \
	 ../config.h ../include/command.h ../include/context.h \
	../include/datefunc.h ../include/debug.h ../include/misc.h \
	../include/timefunc.h
err14.obj : err14.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
optsi.obj : optsi.c \
	 ../config.h ../err_fcts.h ../include/cmdline.h ../include/command.h \
	../include/datefunc.h ../include/debug.h ../include/misc.h \
	../include/timefunc.h
err51.obj : err51.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err16.obj : err16.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err53.obj : err53.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
vcgetstr.obj : vcgetstr.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
err18.obj : err18.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err55.obj : err55.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
farread.obj : farread.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
err57.obj : err57.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
alprmblk.obj : alprmblk.c \
	 ../config.h ../context.h_c ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/kswap.h ../include/misc.h \
	../include/timefunc.h
err59.obj : err59.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
scanopt.obj : scanopt.c \
	 ../config.h ../err_fcts.h ../include/cmdline.h ../include/command.h \
	../include/datefunc.h ../include/debug.h ../include/misc.h \
	../include/timefunc.h
openf.obj : openf.c \
	 ../config.h ../include/debug.h ../include/openf.h
messages.obj : messages.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/res.h ../include/resource.h \
	../include/strings.typ ../include/timefunc.h ../strings.h
scancmd.obj : scancmd.c \
	 ../config.h ../err_fcts.h ../include/cmdline.h ../include/command.h \
	../include/datefunc.h ../include/debug.h ../include/misc.h \
	../include/timefunc.h
optss.obj : optss.c \
	 ../config.h ../err_fcts.h ../include/cmdline.h ../include/command.h \
	../include/datefunc.h ../include/debug.h ../include/misc.h \
	../include/timefunc.h
ctxt_mk.obj : ctxt_mk.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/context.h \
	../include/crossjmp.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
where.obj : where.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
err2.obj : err2.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
isadev.obj : isadev.c \
	 ../include/openf.h
err4.obj : err4.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err6.obj : err6.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
res_w.obj : res_w.c \
	 ../include/resource.h
err8.obj : err8.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
mktmpfil.obj : mktmpfil.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
cmdinput.obj : cmdinput.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/keys.h ../include/misc.h \
	../include/timefunc.h
fdattr.obj : fdattr.c
exec.obj : exec.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
goxy.obj : goxy.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
fstpcpy.obj : fstpcpy.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
clrline.obj : clrline.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
err21.obj : err21.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
tmpnam.obj : tmpnam.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
err23.obj : err23.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err60.obj : err60.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
frsysblk.obj : frsysblk.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
err25.obj : err25.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
unquote.obj : unquote.c \
	 ../config.h ../include/cmdline.h ../include/debug.h
err62.obj : err62.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
freep.obj : freep.c \
	 ../config.h ../include/cmdline.h ../include/debug.h
err27.obj : err27.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
cgettime.obj : cgettime.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
err64.obj : err64.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
realnum.obj : realnum.c \
	 ../config.h ../include/context.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
err29.obj : err29.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err66.obj : err66.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
tempfile.obj : tempfile.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
inputdos.obj : inputdos.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
chgenvc.obj : chgenvc.c \
	 ../config.h ../include/context.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
dateget.obj : dateget.c \
	 ../config.h ../include/datefunc.h ../include/debug.h
lwr1wd.obj : lwr1wd.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
keyprsd.obj : keyprsd.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
showcmds.obj : showcmds.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
is_pchr.obj : is_pchr.c
is_empty.obj : is_empty.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
dateset.obj : dateset.c \
	 ../config.h ../include/datefunc.h ../include/debug.h
split.obj : split.c \
	 ../config.h ../include/cmdline.h ../include/debug.h
err30.obj : err30.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
nls.obj : nls.c \
	 ../config.h ../include/debug.h ../include/nls.h
match.obj : match.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
err32.obj : err32.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
timeget.obj : timeget.c \
	 ../config.h ../include/debug.h ../include/timefunc.h
compfile.obj : compfile.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
dbg_c.obj : dbg_c.c \
	 ../config.h ../include/debug.h
err34.obj : err34.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
devopen.obj : devopen.c \
	 ../include/openf.h
err36.obj : err36.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err38.obj : err38.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
num_fmt.obj : num_fmt.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
lowexec.obj : lowexec.asm \
	 .\..\include\large.inc .\..\include\model.inc .\..\include\small.inc \
	.\..\include\stuff.inc
ctxt_adr.obj : ctxt_adr.c \
	 ../config.h ../include/context.h ../include/debug.h
timeset.obj : timeset.c \
	 ../config.h ../include/debug.h ../include/timefunc.h
nls_time.obj : nls_time.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/nls.h ../include/timefunc.h ../strings.h
trim.obj : trim.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
cwd.obj : cwd.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
dbg_s.obj : dbg_s.c \
	 ../config.h ../include/debug.h
is_fnamc.obj : is_fnamc.c \
	 ../config.h ../include/debug.h ../include/nls.h
grabfcom.obj : grabfcom.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
prprompt.obj : prprompt.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
sumblink.obj : sumblink.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
msg_fstr.obj : msg_fstr.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/strings.typ ../include/timefunc.h \
	../strings.h
skqwd.obj : skqwd.c \
	 ../config.h ../include/cmdline.h ../include/command.h \
	../include/datefunc.h ../include/debug.h ../include/misc.h \
	../include/timefunc.h
mk_rddir.obj : mk_rddir.c \
	 ../config.h ../err_fcts.h ../include/cmdline.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err41.obj : err41.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err43.obj : err43.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
msg_gpt.obj : msg_gpt.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
err45.obj : err45.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
fcompl1.obj : fcompl1.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
curdatel.obj : curdatel.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/nls.h \
	../include/timefunc.h ../strings.h
err47.obj : err47.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err49.obj : err49.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
exec1.obj : exec1.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
ctxt_get.obj : ctxt_get.c \
	 ../config.h ../include/context.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
txtlend.obj : txtlend.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
vcgetch.obj : vcgetch.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/keys.h ../include/misc.h ../include/timefunc.h
msg_get.obj : msg_get.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
optsb.obj : optsb.c \
	 ../config.h ../err_fcts.h ../include/cmdline.h ../include/command.h \
	../include/datefunc.h ../include/debug.h ../include/misc.h \
	../include/timefunc.h
resfile.obj : resfile.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
rmtmpfil.obj : rmtmpfil.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
err11.obj : err11.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err13.obj : err13.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
cgetch.obj : cgetch.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/keys.h ../include/misc.h \
	../include/timefunc.h
ctxt_set.obj : ctxt_set.c \
	 ../config.h ../include/context.h ../include/debug.h
err50.obj : err50.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err15.obj : err15.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
pr_time.obj : pr_time.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/nls.h \
	../include/timefunc.h
err52.obj : err52.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
ctxt_pop.obj : ctxt_pop.c \
	 ../config.h ../err_fcts.h ../include/context.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
err17.obj : err17.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err54.obj : err54.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err19.obj : err19.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err56.obj : err56.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
dispcnt.obj : dispcnt.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
ctxt_as.obj : ctxt_as.c \
	 ../config.h ../include/command.h ../include/context.h \
	../include/datefunc.h ../include/debug.h ../include/misc.h \
	../include/timefunc.h
err58.obj : err58.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
gallstr.obj : gallstr.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
err1.obj : err1.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
res_r.obj : res_r.c \
	 ../include/resource.h
msg_mkey.obj : msg_mkey.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
err3.obj : err3.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
brk_get.obj : brk_get.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
err5.obj : err5.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
ctxt_inf.obj : ctxt_inf.c \
	 ../config.h ../include/context.h ../include/debug.h
err7.obj : err7.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err9.obj : err9.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
nls_date.obj : nls_date.c \
	 ../config.h ../include/debug.h ../include/nls.h
brk_set.obj : brk_set.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
err20.obj : err20.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
msg_dps.obj : msg_dps.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
err22.obj : err22.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
dbg_sn.obj : dbg_sn.c \
	 ../config.h ../include/debug.h
err24.obj : err24.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err61.obj : err61.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err26.obj : err26.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err63.obj : err63.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err28.obj : err28.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err65.obj : err65.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
cbs.obj : cbs.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
curtime.obj : curtime.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/nls.h \
	../include/timefunc.h
salloc.obj : salloc.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
chgdrv.obj : chgdrv.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h ../strings.h
alsysblk.obj : alsysblk.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
samefile.obj : samefile.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h
ltrim.obj : ltrim.c \
	 ../config.h ../include/cmdline.h ../include/debug.h
ctxt_mkn.obj : ctxt_mkn.c \
	 ../config.h ../include/context.h ../include/debug.h
leadopt.obj : leadopt.c \
	 ../config.h ../err_fcts.h ../include/cmdline.h ../include/command.h \
	../include/datefunc.h ../include/debug.h ../include/misc.h \
	../include/timefunc.h
chgenvr.obj : chgenvr.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err31.obj : err31.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
rtrim.obj : rtrim.c \
	 ../config.h ../include/cmdline.h ../include/debug.h
ctxt_vw.obj : ctxt_vw.c \
	 ../config.h ../include/context.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err33.obj : err33.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
msg_dflt.obj : msg_dflt.c \
	 ../config.h ../include/datefunc.h ../include/debug.h \
	../include/misc.h ../include/timefunc.h ../strings.h
err35.obj : err35.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
err37.obj : err37.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
pr_prmpt.obj : pr_prmpt.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
ctxt_chg.obj : ctxt_chg.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/context.h \
	../include/datefunc.h ../include/debug.h ../include/misc.h \
	../include/timefunc.h
chgctxt.obj : chgctxt.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/context.h \
	../include/datefunc.h ../include/debug.h ../include/misc.h \
	../include/timefunc.h
err39.obj : err39.c \
	 ../config.h ../err_fcts.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h ../strings.h
fillcomp.obj : fillcomp.c \
	 ../config.h ../include/command.h ../include/datefunc.h \
	../include/debug.h ../include/misc.h ../include/timefunc.h
DYNSOURCES =
#MAKEDEP STOP

clobber : clean
	$(RM) $(RMFLAGS) *.com *.cln *.lib *.lst *.cfg lib.mak

clean : 
	$(RM) $(RMFLAGS) *.lst *.map *.bin *.bak *.las *.obj *.exe $(CFG) *.dmp com.com tags errlist lib.m3


.IF $(CFG) != $(NULL)

#CONFIGURATION = $(CONF_BASE) $(null,$(NDEBUG) $(CONF_DBG) $(CONF_NDBG))
CONFIGURATION = $(CONF_BASE)

.IF $(_COMPTYPE) == BC
CONF_BASE =	\
-f- \
-I$(INCDIR:s/;/ /:t";")	\
-L$(LIBDIR:s/;/ /:t";")	\
-w

.IF $(_COMPILER)==BC5
CONFIGURATION += -RT- -x-
.ENDIF

CONF_DBG =	$(MYCFLAGS_DBG)

CONF_NDBG =	$(MYCFLAGS_NDBG)

.ENDIF

.IF $(_COMPTYPE) == TC
CONF_BASE =	\
-I$(INCDIR:s/;/ /:t";")	\
-L$(LIBDIR:s/;/ /:t";")	\
-w

# The "-f-" causes that TCC passes option "/r" to the assembler, though
# ASM chokes about it

CONF_DBG =	$(MYCFLAGS_DBG)

CONF_NDBG =	$(MYCFLAGS_NDBG)

.ENDIF


.ENDIF
#-weas	\
#-wpre	\
#-w-pro	\

lib.mak : makefile lib.m1 lib.m2
	..\utils\chunk freecom_deps <$(mktmp $(OBJ:t"\n")\n) >lib.m3
	+copy lib.m1 + lib.m3 + $(mktmp freecom.lib : \44(CFG) freecom_deps \n\tif exist freecom.lib \44(TLIB) freecom.lib /c @&&|\n+-$(OBJ:t" &\\n+-")\n| , freecom.lst \n\tif not exist freecom.lib \44(TLIB) freecom.lib /c @&&|\n+$(OBJ:t" &\\n+")\n| , freecom.lst \n) + lib.m2 $@
#	+copy lib.m1 + $(mktmp freecom.lib : \44(CFG) $(OBJ:t" \\\\\\n\\t") \n\tif exist freecom.lib \44(TLIB) freecom.lib /c @&&|\n+-$(OBJ:t" &\\n+-")\n| , freecom.lst \n\tif not exist freecom.lib \44(TLIB) freecom.lib /c @&&|\n+$(OBJ:t" &\\n+")\n| , freecom.lst \n) + lib.m2 $@

