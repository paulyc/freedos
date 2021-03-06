.AUTODEPEND

CFG = TCCDOS.CFG
CFG_DEPENDENCIES = lib.mak

all: $(CFG) freecom.lib

##>> Modify this file with your local settings
!include "..\config.mak"

freecom_deps :  \
	act_qec.obj \
	add_arg.obj \
	alloc_e1.obj \
	alloc_ec.obj \
	alloc_ed.obj \
	alloc_em.obj \
	alloc_er.obj \
	alloc_es.obj \
	alprmblk.obj \
	alsysblk.obj \
	beep_l.obj \
	beep_n.obj \
	brk_get.obj \
	brk_set.obj \
	cbreak.obj \
	cbs.obj \
	cd_dir.obj \
	cgetch.obj \
	cgettime.obj \
	chgctxt.obj \
	chgdrv.obj \
	chgenv.obj \
	chgenvc.obj \
	chgenvr.obj \
	clrline.obj \
	cmdifile.obj \
	cmdinput.obj \
	comfile.obj \
	compfile.obj \
	corefar.obj \
	corenear.obj \
	ctxt.obj \
	ctxt_1.obj \
	ctxt_2.obj \
	ctxt_3.obj \
	ctxt_adr.obj \
	ctxt_as.obj \
	ctxt_chg.obj \
	ctxt_clr.obj \
	ctxt_get.obj \
	ctxt_inf.obj \
	ctxt_mk.obj \
	ctxt_mkn.obj \
	ctxt_mks.obj \
	ctxt_po2.obj \
	ctxt_pop.obj \
	ctxt_psh.obj \
	ctxt_rnu.obj \
	ctxt_ses.obj \
	ctxt_set.obj \
	ctxt_sp.obj \
	ctxt_ss.obj \
	ctxt_vw.obj \
	ctxtfree.obj \
	curdatel.obj \
	curtime.obj \
	cwd.obj \
	dateget.obj \
	dateset.obj \
	dbg_c.obj \
	dbg_cptr.obj \
	dbg_free.obj \
	dbg_mem.obj \
	dbg_prnt.obj \
	dbg_s.obj \
	dbg_sn.obj \
	dbg_v1.obj \
	devopen.obj \
	dispcnt.obj \
	drvnum.obj \
	ecenum.obj \
	ecfrivar.obj \
	eclastb.obj \
	ecmk.obj \
	ecmk_c.obj \
	ecmk_f.obj \
	ecmk_s.obj \
	ecmkb.obj \
	ecmkf.obj \
	ecmkfd.obj \
	ecmkhc.obj \
	ecmkivar.obj \
	ecmks.obj \
	ecmksc.obj \
	ecmkv1c.obj \
	ecmkvcmd.obj \
	ecmkverb.obj \
	ecpop.obj \
	ecpushst.obj \
	ecscarg.obj \
	ecsets.obj \
	ecstring.obj \
	efct_001.obj \
	efct_002.obj \
	efct_003.obj \
	esdec.obj \
	esenc.obj \
	exec.obj \
	exec1.obj \
	exp_ev.obj \
	farread.obj \
	fcompl1.obj \
	fcompl2.obj \
	fdattr.obj \
	fdevopen.obj \
	fillcomp.obj \
	find.obj \
	find_arg.obj \
	freep.obj \
	frsysblk.obj \
	fstpcpy.obj \
	gallstr.obj \
	get1mcb.obj \
	getcnam.obj \
	getenv.obj \
	goxy.obj \
	grabfcom.obj \
	gumblink.obj \
	hdlrctxt.obj \
	hist_get.obj \
	hist_set.obj \
	i_tty.obj \
	inputdos.obj \
	is_alias.obj \
	is_empty.obj \
	is_fnamc.obj \
	chunk1

chunk1 :  \
	is_fnstr.obj \
	is_icmd.obj \
	is_ifct.obj \
	is_ivar.obj \
	is_num.obj \
	is_pch.obj \
	is_pchr.obj \
	is_quote.obj \
	isadev.obj \
	ivarset.obj \
	keyprsd.obj \
	lastdget.obj \
	lastdset.obj \
	leadopt.obj \
	lowexec.obj \
	ltrimcl.obj \
	ltrimsp.obj \
	lwr1wd.obj \
	match.obj \
	messages.obj \
	mk_rddir.obj \
	mktmpfil.obj \
	msg_dflt.obj \
	msg_dps.obj \
	msg_fstr.obj \
	msg_get.obj \
	msg_gpt.obj \
	msg_mkey.obj \
	msg_prmp.obj \
	msg_v1.obj \
	mux_ae.obj \
	nls.obj \
	nls_date.obj \
	nls_time.obj \
	num_fmt.obj \
	o_blank.obj \
	o_blks.obj \
	o_ch.obj \
	o_cleft.obj \
	o_flush.obj \
	o_fnl.obj \
	o_gcur.obj \
	o_id.obj \
	o_init.obj \
	o_istty.obj \
	o_mem.obj \
	o_modes.obj \
	o_nl.obj \
	o_nsize.obj \
	o_pad.obj \
	o_str.obj \
	obsolete.obj \
	onoff.obj \
	openf.obj \
	optsb.obj \
	optsi.obj \
	optss.obj \
	parsenum.obj \
	pr_date.obj \
	pr_prmpt.obj \
	pr_time.obj \
	prprompt.obj \
	purgemem.obj \
	realnum.obj \
	reg_str.obj \
	res.obj \
	res_r.obj \
	res_w.obj \
	resfile.obj \
	rmtmpfil.obj \
	rtrimcl.obj \
	rtrimsp.obj \
	salloc.obj \
	samefile.obj \
	scancmd.obj \
	scanopt.obj \
	set_arg.obj \
	showcmds.obj \
	skiparg.obj \
	skipchrs.obj \
	skippath.obj \
	skipquot.obj \
	skqwd.obj \
	spfnam.obj \
	split.obj \
	splitfc.obj \
	sumblink.obj \
	tempfile.obj \
	timeget.obj \
	timeset.obj \
	tmpnam.obj \
	trimcl.obj \
	trimsp.obj \
	txtlend.obj \
	unquote.obj \
	vcgetch.obj \
	vcgetstr.obj \
	where.obj \
	err1.obj \
	err2.obj \
	err3.obj \
	err4.obj \
	err5.obj \
	err6.obj \
	err7.obj \
	err8.obj \
	err9.obj \
	err10.obj \
	err11.obj \
	err12.obj \
	err13.obj \
	err14.obj \
	err15.obj \
	err16.obj \
	err17.obj \
	err18.obj \
	err19.obj \
	err20.obj \
	err21.obj \
	err22.obj \
	err23.obj \
	err24.obj \
	err25.obj \
	err26.obj \
	err27.obj \
	err28.obj \
	err29.obj \
	chunk2

chunk2 :  \
	err30.obj \
	err31.obj \
	err32.obj \
	err33.obj \
	err34.obj \
	err35.obj \
	err36.obj \
	err37.obj \
	err38.obj \
	err39.obj \
	err40.obj \
	err41.obj \
	err42.obj \
	err43.obj \
	err44.obj \
	err45.obj \
	err46.obj \
	err47.obj \
	err48.obj \
	err49.obj \
	err50.obj \
	err51.obj \
	err52.obj \
	err53.obj \
	err54.obj \
	err55.obj \
	err56.obj \
	err57.obj \
	err58.obj \
	err59.obj \
	err60.obj \
	err61.obj \
	err62.obj \
	err63.obj \
	err64.obj \
	err65.obj \
	err66.obj \
	err67.obj \
	err68.obj \
	err69.obj \
	err70.obj \
	err71.obj \
	err72.obj \
	err73.obj \
	err74.obj \
	err75.obj \
	err76.obj \
	err77.obj \
	err78.obj \
	err79.obj \
	err80.obj \
	err81.obj \
	err82.obj \
	err83.obj \
	err84.obj \
	err85.obj \
	err86.obj


freecom.lib : $(CFG) freecom_deps 
	if exist freecom.lib $(AR) freecom.lib /c @&&|
+-act_qec.obj &
+-add_arg.obj &
+-alloc_e1.obj &
+-alloc_ec.obj &
+-alloc_ed.obj &
+-alloc_em.obj &
+-alloc_er.obj &
+-alloc_es.obj &
+-alprmblk.obj &
+-alsysblk.obj &
+-beep_l.obj &
+-beep_n.obj &
+-brk_get.obj &
+-brk_set.obj &
+-cbreak.obj &
+-cbs.obj &
+-cd_dir.obj &
+-cgetch.obj &
+-cgettime.obj &
+-chgctxt.obj &
+-chgdrv.obj &
+-chgenv.obj &
+-chgenvc.obj &
+-chgenvr.obj &
+-clrline.obj &
+-cmdifile.obj &
+-cmdinput.obj &
+-comfile.obj &
+-compfile.obj &
+-corefar.obj &
+-corenear.obj &
+-ctxt.obj &
+-ctxt_1.obj &
+-ctxt_2.obj &
+-ctxt_3.obj &
+-ctxt_adr.obj &
+-ctxt_as.obj &
+-ctxt_chg.obj &
+-ctxt_clr.obj &
+-ctxt_get.obj &
+-ctxt_inf.obj &
+-ctxt_mk.obj &
+-ctxt_mkn.obj &
+-ctxt_mks.obj &
+-ctxt_po2.obj &
+-ctxt_pop.obj &
+-ctxt_psh.obj &
+-ctxt_rnu.obj &
+-ctxt_ses.obj &
+-ctxt_set.obj &
+-ctxt_sp.obj &
+-ctxt_ss.obj &
+-ctxt_vw.obj &
+-ctxtfree.obj &
+-curdatel.obj &
+-curtime.obj &
+-cwd.obj &
+-dateget.obj &
+-dateset.obj &
+-dbg_c.obj &
+-dbg_cptr.obj &
+-dbg_free.obj &
+-dbg_mem.obj &
+-dbg_prnt.obj &
+-dbg_s.obj &
+-dbg_sn.obj &
+-dbg_v1.obj &
+-devopen.obj &
+-dispcnt.obj &
+-drvnum.obj &
+-ecenum.obj &
+-ecfrivar.obj &
+-eclastb.obj &
+-ecmk.obj &
+-ecmk_c.obj &
+-ecmk_f.obj &
+-ecmk_s.obj &
+-ecmkb.obj &
+-ecmkf.obj &
+-ecmkfd.obj &
+-ecmkhc.obj &
+-ecmkivar.obj &
+-ecmks.obj &
+-ecmksc.obj &
+-ecmkv1c.obj &
+-ecmkvcmd.obj &
+-ecmkverb.obj &
+-ecpop.obj &
+-ecpushst.obj &
+-ecscarg.obj &
+-ecsets.obj &
+-ecstring.obj &
+-efct_001.obj &
+-efct_002.obj &
+-efct_003.obj &
+-esdec.obj &
+-esenc.obj &
+-exec.obj &
+-exec1.obj &
+-exp_ev.obj &
+-farread.obj &
+-fcompl1.obj &
+-fcompl2.obj &
+-fdattr.obj &
+-fdevopen.obj &
+-fillcomp.obj &
+-find.obj &
+-find_arg.obj &
+-freep.obj &
+-frsysblk.obj &
+-fstpcpy.obj &
+-gallstr.obj &
+-get1mcb.obj &
+-getcnam.obj &
+-getenv.obj &
+-goxy.obj &
+-grabfcom.obj &
+-gumblink.obj &
+-hdlrctxt.obj &
+-hist_get.obj &
+-hist_set.obj &
+-i_tty.obj &
+-inputdos.obj &
+-is_alias.obj &
+-is_empty.obj &
+-is_fnamc.obj &
+-is_fnstr.obj &
+-is_icmd.obj &
+-is_ifct.obj &
+-is_ivar.obj &
+-is_num.obj &
+-is_pch.obj &
+-is_pchr.obj &
+-is_quote.obj &
+-isadev.obj &
+-ivarset.obj &
+-keyprsd.obj &
+-lastdget.obj &
+-lastdset.obj &
+-leadopt.obj &
+-lowexec.obj &
+-ltrimcl.obj &
+-ltrimsp.obj &
+-lwr1wd.obj &
+-match.obj &
+-messages.obj &
+-mk_rddir.obj &
+-mktmpfil.obj &
+-msg_dflt.obj &
+-msg_dps.obj &
+-msg_fstr.obj &
+-msg_get.obj &
+-msg_gpt.obj &
+-msg_mkey.obj &
+-msg_prmp.obj &
+-msg_v1.obj &
+-mux_ae.obj &
+-nls.obj &
+-nls_date.obj &
+-nls_time.obj &
+-num_fmt.obj &
+-o_blank.obj &
+-o_blks.obj &
+-o_ch.obj &
+-o_cleft.obj &
+-o_flush.obj &
+-o_fnl.obj &
+-o_gcur.obj &
+-o_id.obj &
+-o_init.obj &
+-o_istty.obj &
+-o_mem.obj &
+-o_modes.obj &
+-o_nl.obj &
+-o_nsize.obj &
+-o_pad.obj &
+-o_str.obj &
+-obsolete.obj &
+-onoff.obj &
+-openf.obj &
+-optsb.obj &
+-optsi.obj &
+-optss.obj &
+-parsenum.obj &
+-pr_date.obj &
+-pr_prmpt.obj &
+-pr_time.obj &
+-prprompt.obj &
+-purgemem.obj &
+-realnum.obj &
+-reg_str.obj &
+-res.obj &
+-res_r.obj &
+-res_w.obj &
+-resfile.obj &
+-rmtmpfil.obj &
+-rtrimcl.obj &
+-rtrimsp.obj &
+-salloc.obj &
+-samefile.obj &
+-scancmd.obj &
+-scanopt.obj &
+-set_arg.obj &
+-showcmds.obj &
+-skiparg.obj &
+-skipchrs.obj &
+-skippath.obj &
+-skipquot.obj &
+-skqwd.obj &
+-spfnam.obj &
+-split.obj &
+-splitfc.obj &
+-sumblink.obj &
+-tempfile.obj &
+-timeget.obj &
+-timeset.obj &
+-tmpnam.obj &
+-trimcl.obj &
+-trimsp.obj &
+-txtlend.obj &
+-unquote.obj &
+-vcgetch.obj &
+-vcgetstr.obj &
+-where.obj &
+-err1.obj &
+-err2.obj &
+-err3.obj &
+-err4.obj &
+-err5.obj &
+-err6.obj &
+-err7.obj &
+-err8.obj &
+-err9.obj &
+-err10.obj &
+-err11.obj &
+-err12.obj &
+-err13.obj &
+-err14.obj &
+-err15.obj &
+-err16.obj &
+-err17.obj &
+-err18.obj &
+-err19.obj &
+-err20.obj &
+-err21.obj &
+-err22.obj &
+-err23.obj &
+-err24.obj &
+-err25.obj &
+-err26.obj &
+-err27.obj &
+-err28.obj &
+-err29.obj &
+-err30.obj &
+-err31.obj &
+-err32.obj &
+-err33.obj &
+-err34.obj &
+-err35.obj &
+-err36.obj &
+-err37.obj &
+-err38.obj &
+-err39.obj &
+-err40.obj &
+-err41.obj &
+-err42.obj &
+-err43.obj &
+-err44.obj &
+-err45.obj &
+-err46.obj &
+-err47.obj &
+-err48.obj &
+-err49.obj &
+-err50.obj &
+-err51.obj &
+-err52.obj &
+-err53.obj &
+-err54.obj &
+-err55.obj &
+-err56.obj &
+-err57.obj &
+-err58.obj &
+-err59.obj &
+-err60.obj &
+-err61.obj &
+-err62.obj &
+-err63.obj &
+-err64.obj &
+-err65.obj &
+-err66.obj &
+-err67.obj &
+-err68.obj &
+-err69.obj &
+-err70.obj &
+-err71.obj &
+-err72.obj &
+-err73.obj &
+-err74.obj &
+-err75.obj &
+-err76.obj &
+-err77.obj &
+-err78.obj &
+-err79.obj &
+-err80.obj &
+-err81.obj &
+-err82.obj &
+-err83.obj &
+-err84.obj &
+-err85.obj &
+-err86.obj
| , freecom.lst 
	if not exist freecom.lib $(AR) freecom.lib /c @&&|
+act_qec.obj &
+add_arg.obj &
+alloc_e1.obj &
+alloc_ec.obj &
+alloc_ed.obj &
+alloc_em.obj &
+alloc_er.obj &
+alloc_es.obj &
+alprmblk.obj &
+alsysblk.obj &
+beep_l.obj &
+beep_n.obj &
+brk_get.obj &
+brk_set.obj &
+cbreak.obj &
+cbs.obj &
+cd_dir.obj &
+cgetch.obj &
+cgettime.obj &
+chgctxt.obj &
+chgdrv.obj &
+chgenv.obj &
+chgenvc.obj &
+chgenvr.obj &
+clrline.obj &
+cmdifile.obj &
+cmdinput.obj &
+comfile.obj &
+compfile.obj &
+corefar.obj &
+corenear.obj &
+ctxt.obj &
+ctxt_1.obj &
+ctxt_2.obj &
+ctxt_3.obj &
+ctxt_adr.obj &
+ctxt_as.obj &
+ctxt_chg.obj &
+ctxt_clr.obj &
+ctxt_get.obj &
+ctxt_inf.obj &
+ctxt_mk.obj &
+ctxt_mkn.obj &
+ctxt_mks.obj &
+ctxt_po2.obj &
+ctxt_pop.obj &
+ctxt_psh.obj &
+ctxt_rnu.obj &
+ctxt_ses.obj &
+ctxt_set.obj &
+ctxt_sp.obj &
+ctxt_ss.obj &
+ctxt_vw.obj &
+ctxtfree.obj &
+curdatel.obj &
+curtime.obj &
+cwd.obj &
+dateget.obj &
+dateset.obj &
+dbg_c.obj &
+dbg_cptr.obj &
+dbg_free.obj &
+dbg_mem.obj &
+dbg_prnt.obj &
+dbg_s.obj &
+dbg_sn.obj &
+dbg_v1.obj &
+devopen.obj &
+dispcnt.obj &
+drvnum.obj &
+ecenum.obj &
+ecfrivar.obj &
+eclastb.obj &
+ecmk.obj &
+ecmk_c.obj &
+ecmk_f.obj &
+ecmk_s.obj &
+ecmkb.obj &
+ecmkf.obj &
+ecmkfd.obj &
+ecmkhc.obj &
+ecmkivar.obj &
+ecmks.obj &
+ecmksc.obj &
+ecmkv1c.obj &
+ecmkvcmd.obj &
+ecmkverb.obj &
+ecpop.obj &
+ecpushst.obj &
+ecscarg.obj &
+ecsets.obj &
+ecstring.obj &
+efct_001.obj &
+efct_002.obj &
+efct_003.obj &
+esdec.obj &
+esenc.obj &
+exec.obj &
+exec1.obj &
+exp_ev.obj &
+farread.obj &
+fcompl1.obj &
+fcompl2.obj &
+fdattr.obj &
+fdevopen.obj &
+fillcomp.obj &
+find.obj &
+find_arg.obj &
+freep.obj &
+frsysblk.obj &
+fstpcpy.obj &
+gallstr.obj &
+get1mcb.obj &
+getcnam.obj &
+getenv.obj &
+goxy.obj &
+grabfcom.obj &
+gumblink.obj &
+hdlrctxt.obj &
+hist_get.obj &
+hist_set.obj &
+i_tty.obj &
+inputdos.obj &
+is_alias.obj &
+is_empty.obj &
+is_fnamc.obj &
+is_fnstr.obj &
+is_icmd.obj &
+is_ifct.obj &
+is_ivar.obj &
+is_num.obj &
+is_pch.obj &
+is_pchr.obj &
+is_quote.obj &
+isadev.obj &
+ivarset.obj &
+keyprsd.obj &
+lastdget.obj &
+lastdset.obj &
+leadopt.obj &
+lowexec.obj &
+ltrimcl.obj &
+ltrimsp.obj &
+lwr1wd.obj &
+match.obj &
+messages.obj &
+mk_rddir.obj &
+mktmpfil.obj &
+msg_dflt.obj &
+msg_dps.obj &
+msg_fstr.obj &
+msg_get.obj &
+msg_gpt.obj &
+msg_mkey.obj &
+msg_prmp.obj &
+msg_v1.obj &
+mux_ae.obj &
+nls.obj &
+nls_date.obj &
+nls_time.obj &
+num_fmt.obj &
+o_blank.obj &
+o_blks.obj &
+o_ch.obj &
+o_cleft.obj &
+o_flush.obj &
+o_fnl.obj &
+o_gcur.obj &
+o_id.obj &
+o_init.obj &
+o_istty.obj &
+o_mem.obj &
+o_modes.obj &
+o_nl.obj &
+o_nsize.obj &
+o_pad.obj &
+o_str.obj &
+obsolete.obj &
+onoff.obj &
+openf.obj &
+optsb.obj &
+optsi.obj &
+optss.obj &
+parsenum.obj &
+pr_date.obj &
+pr_prmpt.obj &
+pr_time.obj &
+prprompt.obj &
+purgemem.obj &
+realnum.obj &
+reg_str.obj &
+res.obj &
+res_r.obj &
+res_w.obj &
+resfile.obj &
+rmtmpfil.obj &
+rtrimcl.obj &
+rtrimsp.obj &
+salloc.obj &
+samefile.obj &
+scancmd.obj &
+scanopt.obj &
+set_arg.obj &
+showcmds.obj &
+skiparg.obj &
+skipchrs.obj &
+skippath.obj &
+skipquot.obj &
+skqwd.obj &
+spfnam.obj &
+split.obj &
+splitfc.obj &
+sumblink.obj &
+tempfile.obj &
+timeget.obj &
+timeset.obj &
+tmpnam.obj &
+trimcl.obj &
+trimsp.obj &
+txtlend.obj &
+unquote.obj &
+vcgetch.obj &
+vcgetstr.obj &
+where.obj &
+err1.obj &
+err2.obj &
+err3.obj &
+err4.obj &
+err5.obj &
+err6.obj &
+err7.obj &
+err8.obj &
+err9.obj &
+err10.obj &
+err11.obj &
+err12.obj &
+err13.obj &
+err14.obj &
+err15.obj &
+err16.obj &
+err17.obj &
+err18.obj &
+err19.obj &
+err20.obj &
+err21.obj &
+err22.obj &
+err23.obj &
+err24.obj &
+err25.obj &
+err26.obj &
+err27.obj &
+err28.obj &
+err29.obj &
+err30.obj &
+err31.obj &
+err32.obj &
+err33.obj &
+err34.obj &
+err35.obj &
+err36.obj &
+err37.obj &
+err38.obj &
+err39.obj &
+err40.obj &
+err41.obj &
+err42.obj &
+err43.obj &
+err44.obj &
+err45.obj &
+err46.obj &
+err47.obj &
+err48.obj &
+err49.obj &
+err50.obj &
+err51.obj &
+err52.obj &
+err53.obj &
+err54.obj &
+err55.obj &
+err56.obj &
+err57.obj &
+err58.obj &
+err59.obj &
+err60.obj &
+err61.obj &
+err62.obj &
+err63.obj &
+err64.obj &
+err65.obj &
+err66.obj &
+err67.obj &
+err68.obj &
+err69.obj &
+err70.obj &
+err71.obj &
+err72.obj &
+err73.obj &
+err74.obj &
+err75.obj &
+err76.obj &
+err77.obj &
+err78.obj &
+err79.obj &
+err80.obj &
+err81.obj &
+err82.obj &
+err83.obj &
+err84.obj &
+err85.obj &
+err86.obj
| , freecom.lst 

