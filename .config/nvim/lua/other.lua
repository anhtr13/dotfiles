-- ============================
-- Statusline
-- ============================

local function git_branch()
	local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
	if branch ~= "" then
		return " [" .. branch .. "]"
	end
	return ""
end

local function file_type()
	return vim.bo.filetype
end

local function file_size()
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

local function mode_icon()
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

_G.mode_icon = mode_icon
_G.git_branch = git_branch
_G.file_type = file_type
_G.file_size = file_size

vim.cmd([[
  highlight StatusLineBold gui=bold cterm=bold
]])

vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	callback = function()
		vim.opt_local.statusline = table.concat({
			"  ",
			"%#StatusLineBold#",
			"%{v:lua.mode_icon()}  | ",
			"%{v:lua.git_branch()} %f",
			"%#StatusLine#",
			"%=", -- Right-align everything after this
			"%{v:lua.file_size()} / %{v:lua.file_type()}  |  %l:%c / %P  ",
		})
	end,
})
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	callback = function()
		vim.opt_local.statusline = "  %{v:lua.git_branch()} %f%=%{v:lua.file_type()}  |  %l:%c / %P  "
	end,
})

-- ============================
-- User commands
-- ============================

vim.api.nvim_create_user_command(
	"InstallLSPs",
	"MasonInstall bash-language-server cmake-language-server dockerfile-language-server gopls json-lsp lua-language-server nginx-language-server pylyzer systemd-language-server tailwindcss-language-server vtsls vue-language-server yaml-language-server",
	{
		bang = true,
		desc = "Install formatter via Mason",
	}
)

vim.api.nvim_create_user_command(
	"InstallFomatters",
	"MasonInstall black codespell goimports-reviser golines isort nginx-config-formatter prettierd shfmt sql-formatter stylua tombi",
	{
		bang = true,
		desc = "Install formatter via Mason",
	}
)

-- ============================
-- Break-points
-- ============================

vim.api.nvim_set_hl(0, "red", { ctermbg = 0, fg = "#e06c75", bg = "#31353f" })
vim.api.nvim_set_hl(0, "blue", { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
vim.api.nvim_set_hl(0, "green", { ctermbg = 0, fg = "#98c379", bg = "#31353f" })
vim.api.nvim_set_hl(0, "yellow", { ctermbg = 0, fg = "#e5c07b", bg = "#31353f" })

vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "red", linehl = "red", numhl = "red" })
vim.fn.sign_define("DapBreakpointCondition", { text = "󰟃", texthl = "blue", linehl = "blue", numhl = "blue" })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "red", linehl = "red", numhl = "red" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "yellow", linehl = "yellow", numhl = "yellow" })
vim.fn.sign_define("DapStopped", { text = "", texthl = "green", linehl = "green", numhl = "green" })

-- ============================
-- Diagnostics
-- ============================

vim.diagnostic.config({
	virtual_text = true,
	virtual_lines = false,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
		linehl = {
			[vim.diagnostic.severity.ERROR] = "ErrorMsg",
		},
		numhl = {
			[vim.diagnostic.severity.WARN] = "WarningMsg",
		},
	},
})

-- ===================================
-- Register additional file extensions
-- ===================================

-- vim.filetype.add({
--   pattern = {
--     ["compose.*%.ya?ml"] = "yaml.docker-compose",
--     ["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
--   },
-- })
-- vim.filetype.add({ extension = { tf = "terraform" } })
-- vim.filetype.add({ extension = { tfvars = "terraform" } })
-- vim.filetype.add({ extension = { pipeline = "groovy" } })
-- vim.filetype.add({ extension = { multibranch = "groovy" } })
