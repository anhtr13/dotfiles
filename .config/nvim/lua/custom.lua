-- ================================
-- Treesitter incremental selection
-- ================================

_G.selected_nodes = {} ---@type TSNode[]

TS_Incremental_Selection = {}

TS_Incremental_Selection.get_node_at_cursor = function()
	local cursor = vim.api.nvim_win_get_cursor(0)
	local row = cursor[1] - 1
	local col = cursor[2]

	local ok, root_parser = pcall(vim.treesitter.get_parser, 0, nil, {})
	if not ok or not root_parser then
		return
	end

	root_parser:parse({ vim.fn.line("w0") - 1, vim.fn.line("w$") })
	local lang_tree = root_parser:language_for_range({ row, col, row, col })

	return lang_tree:named_node_for_range({ row, col, row, col }, { ignore_injections = false })
end

TS_Incremental_Selection.select_node = function(node)
	if not node then
		return
	end
	local start_row, start_col, end_row, end_col = node:range()

	local last_line = vim.api.nvim_buf_line_count(0)
	local end_row_pos = math.min(end_row + 1, last_line)
	local end_col_pos = end_col

	if end_row + 1 > last_line then
		local last_line_text = vim.api.nvim_buf_get_lines(0, last_line - 1, last_line, true)[1]
		end_col_pos = #last_line_text
	end

	local mode = vim.api.nvim_get_mode()
	if mode.mode ~= "v" then
		vim.api.nvim_cmd({ cmd = "normal", bang = true, args = { "v" } }, {})
	end

	vim.api.nvim_win_set_cursor(0, { start_row + 1, start_col })
	vim.cmd("normal! o")
	vim.api.nvim_win_set_cursor(0, { end_row_pos, end_col_pos > 0 and end_col_pos - 1 or 0 })
end

TS_Incremental_Selection.init_selection = function()
	_G.selected_nodes = {}

	local current_node = TS_Incremental_Selection.get_node_at_cursor()
	if not current_node then
		return
	end

	table.insert(_G.selected_nodes, current_node)
	TS_Incremental_Selection.select_node(current_node)
end

TS_Incremental_Selection.incr_selection = function()
	if #_G.selected_nodes == 0 then
		return
	end

	local current_node = _G.selected_nodes[#_G.selected_nodes]

	if not current_node then
		return
	end

	local node = current_node
	local root_searched = false
	while true do
		local parent = node:parent()
		if not parent then
			if root_searched then
				return
			end
			local ok, root_parser = pcall(vim.treesitter.get_parser)
			if not ok or root_parser == nil then
				return
			end
			root_parser:parse({ vim.fn.line("w0") - 1, vim.fn.line("w$") })

			local range = { node:range() }
			local current_parser = root_parser:language_for_range(range)

			if root_parser ~= current_parser then
				local parser = current_parser:parent()
				if parser == nil then
					return
				end
				current_parser = parser
			end

			if root_parser == current_parser then
				root_searched = true
			end

			parent = current_parser:named_node_for_range(range)
			if parent == nil then
				return
			end
		end

		local range = { node:range() }
		local parent_range = { parent:range() }
		if not vim.deep_equal(range, parent_range) then
			table.insert(_G.selected_nodes, parent)
			TS_Incremental_Selection.select_node(parent)
			return
		end
		node = parent
	end
end

TS_Incremental_Selection.decr_selection = function()
	if #_G.selected_nodes > 1 then
		table.remove(_G.selected_nodes)
		local current_node = _G.selected_nodes[#_G.selected_nodes]
		if current_node then
			TS_Incremental_Selection.select_node(current_node)
		end
	end
end

-- ========================
-- Statusline
-- ========================

Statusline = {}

_G.mode_highlight = function()
	local mode = vim.fn.mode()
	if mode == "n" then
		return "%#StatusLineNormal#"
	elseif mode == "i" or mode == "ic" then
		return "%#StatusLineInsert#"
	elseif mode == "v" or mode == "V" or mode == "s" or mode == "S" then
		return "%#StatusLineVisual#"
	elseif mode == "r" or mode == "R" then
		return "%#StatusLineReplace#"
	elseif mode == "c" then
		return "%#StatusLineCommand#"
	elseif mode == "t" then
		return "%#StatusLineTerminal#"
	else
		return "%#StatusLineNormal#"
	end
end

_G.mode_icon = function()
	local mode = vim.fn.mode()
	local modes = {
		n = "NORMAL",
		i = "INSERT",
		v = "VISUAL",
		V = "V-LINE",
		["\22"] = "V-BLOCK", -- Ctrl-V
		c = "COMMAND",
		s = "SELECT",
		S = "S-LINE",
		["\19"] = "S-BLOCK", -- Ctrl-S
		R = "REPLACE",
		r = "REPLACE",
		["!"] = "SHELL",
		t = "TERMINAL",
	}
	return modes[mode] or (mode:upper())
end

_G.git_branch = function()
	local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
	if branch ~= "" then
		return " [" .. branch .. "]"
	end
	return ""
end

_G.file_size = function()
	local size = vim.fn.getfsize(vim.fn.expand("%"))
	if size < 0 then
		return ""
	end
	if size < 1024 then
		return size .. "B"
	elseif size < 1024 * 1024 then
		return string.format("%.1fK", size / 1024)
	else
		return string.format("%.1fM", size / 1024 / 1024)
	end
end

Statusline.setup = function()
	vim.api.nvim_create_autocmd({ "ModeChanged", "BufEnter", "WinEnter", "VimEnter", "InsertEnter", "InsertLeave" }, {
		callback = function()
			local mode_hl = _G.mode_highlight()
			vim.opt_local.statusline = table.concat({
				mode_hl,
				"  %{v:lua.mode_icon()} ",
				"%#StatusLine#",
				"  %<%t%{v:lua.git_branch()} %m%=    %y ",
				"%{v:lua.file_size()}  ",
				mode_hl,
				" %l:%c / %P ",
			})
		end,
	})

	vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
		callback = function()
			vim.opt_local.statusline = " %{v:lua.git_branch()} %<%f    %=%y | %l:%c / %P "
		end,
	})
end

return {
	Statusline = Statusline,
	TS_Incremental_Selection = TS_Incremental_Selection,
}
