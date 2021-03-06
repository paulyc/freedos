/*
 * MD / MKDIR - makes a call to directory_handler to do its work
 */

#include "../config.h"

#include <dir.h>

#include "../include/command.h"
#include "../include/misc.h"

int cmd_mkdir(char *param)
{
	return mk_rd_dir(param, mkdir, "MKDIR");
}
