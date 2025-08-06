-- Installing and managing LSP servers, DAP servers, linters, formatters, etc.
return {
	"mason-org/mason.nvim",
	config = function()
		require("mason").setup({
			-- install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }),

			--- "prepend" | "append" | "skip"
			PATH = "prepend",
			max_concurrent_installers = 3,

			-- log_level = vim.log.levels.INFO,
			-- registries = {
			-- 	"github:mason-org/mason-registry",
			-- },
			-- providers = {
			-- 	"mason.providers.registry-api",
			-- 	"mason.providers.client",
			-- },
			-- github = {
			-- 	download_url_template = "https://github.com/%s/releases/download/%s/%s",
			-- },
			--
			-- pip = {
			-- 	upgrade_pip = false,
			-- 	install_args = {},
			-- },

			ui = {
				-- single | double | rounded | solid | shadow | none
				border = "single",

				-- check_outdated_packages_on_open = true,
				-- backdrop = 60,
				-- width = 0.8,
				-- height = 0.9,

				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},

				-- keymaps = {
				-- 	toggle_package_expand = "<CR>",
				-- 	install_package = "i",
				-- 	update_package = "u",
				-- 	check_package_version = "c",
				-- 	update_all_packages = "U",
				-- 	check_outdated_packages = "C",
				-- 	uninstall_package = "X",
				-- 	cancel_installation = "<C-c>",
				-- 	apply_language_filter = "<C-f>",
				-- 	toggle_package_install_log = "<CR>",
				-- 	toggle_help = "g?",
				-- },
			},
		})
	end,
}
