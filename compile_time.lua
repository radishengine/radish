
compile.suffix {
	begin = compile.include('run_time.lua');
	lib = compile.include_lib('lua');
	data = compile.include_data('data');
}
