-- ========================
-- Statusline
-- ========================

local M = {}

M.mode_highlight = function()
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

M.mode_icon = function()
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

M.git_branch = function()
	local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
	if branch ~= "" then
		return " [" .. branch .. "]"
	end
	return ""
end

M.file_size = function()
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

M.setup = function()
	_G.mode_highlight = M.mode_highlight
	_G.mode_icon = M.mode_icon
	_G.git_branch = M.git_branch
	_G.file_size = M.file_size

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

return M
