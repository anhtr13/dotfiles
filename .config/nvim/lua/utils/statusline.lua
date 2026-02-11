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
	elseif mode == "v" or mode == "V" or mode == "\22" or mode == "s" or mode == "S" or mode == "\19" then
		return "%#StatusLineVisual#"
	elseif mode == "r" or mode == "R" then
		return "%#StatusLineReplace#"
	elseif mode == "c" then
		return "%#StatusLineCommand#"
	elseif mode == "t" or mode == "!" then
		return "%#StatusLineTerminal#"
	else
		return "%#StatusLineNormal#"
	end
end

M.mode_icon = function()
	local mode = vim.fn.mode()
	local modes = {
		n = "NOR",
		i = "INS",
		v = "VIS",
		V = "V-L",
		["\22"] = "V-B", -- Ctrl-V
		c = "CMD",
		s = "SEL",
		S = "S-L",
		["\19"] = "S-B", -- Ctrl-S
		R = "RPL",
		r = "RPL",
		["!"] = "SHELL",
		t = "TERM",
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
				" %{v:lua.mode_icon()} ",
				"%#StatusLine#",
				" %<%t%{v:lua.git_branch()} %m%r%=    %y ",
				"%{v:lua.file_size()} | %P ",
				mode_hl,
				" %l:%c ",
			})
		end,
	})

	vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
		callback = function()
			vim.opt_local.statusline = " %{v:lua.git_branch()} %<%f    %=%y | %P / %l:%c "
		end,
	})
end

return M
