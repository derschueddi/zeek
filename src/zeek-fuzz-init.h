#pragma once

#include <cstdlib>

#include "zeek-setup.h"

extern "C" int LLVMFuzzerInitialize(int* argc, char*** argv)
	{
	zeek::Options options;
	options.scripts_to_load.emplace_back("local.zeek");
	options.script_options_to_set.emplace_back("Site::local_nets={10.0.0.0/8}");
	options.script_options_to_set.emplace_back("Log::default_writer=Log::WRITER_NONE");
	options.deterministic_mode = true;
	options.abort_on_scripting_errors = true;

	if ( zeek::setup(*argc, *argv, &options).code )
		abort();

	return 0;
	}

