return {
	cmd = { "clangd" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		"configure.ac",
	},
	filetypes = { "c", "cpp", "h", "hpp", "objc", "objcpp" },
}
