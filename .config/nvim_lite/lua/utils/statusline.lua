-- ========================
-- ====== Statusline ======
-- ========================

local M = {}

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

M.setup = function()
	_G.mode_icon = M.mode_icon
	_G.git_branch = M.git_branch
	_G.file_size = M.file_size

	vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
		callback = function()
			vim.opt_local.statusline = table.concat({
				"%#Bold#",
				" %{v:lua.mode_icon()} ",
				"%#StatusLine#",
				"| %<%t%{v:lua.git_branch()} %m%=    %y ",
				"%{v:lua.file_size()} | %l:%c / %P ",
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
