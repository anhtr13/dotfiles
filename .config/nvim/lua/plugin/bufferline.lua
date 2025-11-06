return {
	"akinsho/bufferline.nvim",
	event = "BufReadPre",
	dependencies = {
		"moll/vim-bbye",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<Tab>l", ":BufferLineCycleNext<CR>", silent = true, desc = "Jump to next buffer" },
		{ "<Tab>h", ":BufferLineCyclePrev<CR>", silent = true, desc = "Jump to previous buffer" },
		{ "<Tab><Right>", ":BufferLineCycleNext<CR>", silent = true, desc = "Jump to next buffer" },
		{ "<Tab><Left>", ":BufferLineCyclePrev<CR>", silent = true, desc = "Jump to previous buffer" },
		{ "<Tab>cc", ":Bdelete<CR>", silent = true, desc = "Close current buffer" },
		{ "<Tab>co", ":BufferLineCloseOthers<CR>", silent = true, desc = "Close all others buffer" },
		{ "<Tab>ch", ":BufferLineCloseLeft<CR>", silent = true, desc = "Close all left buffers" },
		{ "<Tab>cl", ":BufferLineCloseRight<CR>", silent = true, desc = "Close all right buffers" },
		{ "<Tab>c<Left>", ":BufferLineCloseLeft<CR>", silent = true, desc = "Close all left buffers" },
		{ "<Tab>c<Right>", ":BufferLineCloseRight<CR>", silent = true, desc = "Close all right buffers" },
		{ "<Tab>x", ":Bdelete!<CR>", silent = true, desc = "Force close current buffer" },
		{ "<Tab>od", ":BufferLineSortByDirectory<CR>", silent = true, desc = "Sort buffer by directory" },
		{ "<Tab>oe", ":BufferLineSortByExtension<CR>", silent = true, desc = "Sort buffer by extensiton" },
	},
	config = function()
		require("bufferline").setup({
			options = {
				mode = "buffers", -- set to "tabs" to only show tabpages instead
				themable = true, -- allows highlight groups to be overridden i.e. sets highlights as default
				numbers = "both", -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
				close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
				buffer_close_icon = "✘",
				close_icon = "✘",
				path_components = 1, -- Show only the file name without the directory
				modified_icon = "●",
				left_trunc_marker = "",
				right_trunc_marker = "",
				separator_style = "{'', ''}", -- "slant" | "slope" | "thick" | "thin" | { 'any', 'any' }
				max_name_length = 18,
				max_prefix_length = 18, -- prefix used when a buffer is de-duplicated
				tab_size = 18,
				diagnostics = false,
				diagnostics_update_in_insert = false,
				color_icons = true,
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
				enforce_regular_tabs = true,
				always_show_bufferline = true,
				show_tab_indicators = false,
				indicator = {
					-- icon = '', -- this should be omitted if indicator style is not 'icon'
					style = "underline", -- Options: 'icon', 'underline', 'none'
				},
				icon_pinned = "󰐃",
				minimum_padding = 1,
				maximum_padding = 5,
				maximum_length = 15,
				sort_by = "insert_at_end",
			},
			highlights = {
				buffer_selected = {
					-- fg = '',
					-- bg = '',
					bold = true,
					italic = false,
				},
				separator = {
					fg = "#000000",
				},
				-- separator_selected = {},
				-- tab_selected = {},
				-- background = {},
				-- indicator_selected = {},
				fill = {
					bg = "#000000",
				},
			},
		})
	end,
}
