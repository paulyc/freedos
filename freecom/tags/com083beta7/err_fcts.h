void error_invalid_switch(char c);
void error_out_of_memory(void);
void error_syntax(const char * const s);
void error_nothin_to_do(void);
void error_selfcopy(const char * const s);
void error_long_batchline(const char * const fnam, long linenr);
void error_bfile_vanished(const char * const fnam);
void error_bfile_no_such_label(const char * const fnam, const char * const label);
void error_env(int base, int err_no, const char * const var);
void error_env_var(const char * const var);
void error_env_var_not_found(const char * const var);
void error_invalid_lswitch(const char * const str);
void error_filename_too_long(const char * const fname);
void error_command_too_long(void);
void error_line_too_long(void);
void error_tempfile(void);
void error_close_quote(int quote);
void error_illformed_option(const char * const s);
void error_opt_arg(const char * const  str);
void error_opt_noarg(const char * const  str);
void error_leading_plus(void);
void error_trailing_plus(void);
void error_too_many_parameters(const char * const s);
void error_open_file(const char * const fnam);
void error_read_file(const char * const fnam);
void error_write_file(const char * const fnam);
void error_copy(void);
void error_nothing_to_do(void);
void dispCopy(const char src[], const char dst[], int append);
void error_invalid_number(const char * const s);
void error_init_fully_qualified(const char * const s);
void error_corrupt_command_line(void);
void error_quoted_c_k(void);
void error_path_not_found(void);
void error_ctty_excluded(void);
void error_l_notimplemented(void);
void error_u_notimplemented(void);
void error_restore_session(void);
void error_save_session(void);
void error_no_rw_device(const char * const devname);
void error_ctty_dup(const char * const devname);
void error_no_cwd(int drive);
void error_kswap_alias_size(void);
void error_file_not_found(void);
void error_kswap_allocmem(void);
void error_if_exist(void);
void error_if_errorlevel(void);
void error_if_errorlevel_number(void);
void error_if_command(void);
void error_alias_out_of_memory(void);
void error_alias_insert(void);
void error_alias_no_such(const char * const name);
void error_loading_context(void);
void error_dirfct_failed(const char * const fctname, const char * const dirname);
void error_sfile_not_found(const char * const f);
void error_no_alias_name(const char name[]);
void error_history_size(const char s[]);
void error_context_out_of_memory(void);
void error_no_context_after_swap(void);
void error_out_of_dos_memory(void);
void error_context_length(unsigned long islen, unsigned maxlen);
void error_context_add_status(void);
void error_req_param_missing(void);
void error_bad_command(void);
void error_no_pipe(void);
