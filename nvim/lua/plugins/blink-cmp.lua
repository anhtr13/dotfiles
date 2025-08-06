return {
	"saghen/blink.cmp",
	-- optional: provides snippets for the snippet source
	dependencies = { "rafamadriz/friendly-snippets" },

	-- use a release tag to download pre-built binaries
	version = "1.*",
	-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
	-- build = 'cargo build --release',
	-- If you use nix, you can build from source using latest nightly rust with:
	-- build = 'nix run .#build-plugin',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- See :h blink-cmp-config-keymap for defining keymap
		keymap = {
			preset = "none",
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback_to_mappings" },
			["<C-n>"] = { "select_next", "fallback_to_mappings" },
			["<C-c>"] = { "cancel", "fallback" },
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
			["<Tab>"] = { "snippet_forward", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "fallback" },
			["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<CR>"] = { "accept", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono", -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
		},

		completion = {
			documentation = {
				window = { border = "single" },
				auto_show = true, -- auto show the documentation popup
			},
			menu = {
				border = "single",
				draw = {
					padding = { 0, 1 }, -- padding only on right side
					components = {
						kind_icon = {
							text = function(ctx)
								return " " .. ctx.kind_icon .. ctx.icon_gap .. " "
							end,
						},
					},
				},
			},
		},
		signature = {
			enable = true,
			window = { border = "single" },
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		-- See the fuzzy documentation for more information: https://cmp.saghen.dev/configuration/fuzzy.html
		fuzzy = {
			implementation = "rust",
			sorts = {
				"exact",
				-- defaults
				"score",
				"sort_text",
			},
		},
	},
	opts_extend = { "sources.default" },
}
