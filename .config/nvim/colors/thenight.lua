-- ===================================
-- Color-mix utils
-- ===================================

local base_bg = "#222436"

---@param c  string
local function rgb(c)
	c = string.lower(c)
	return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
end

---@param foreground string foreground color
---@param background string background color
---@param alpha number|string number between 0 and 1. 0 results in bg, 1 results in fg
local function blend(foreground, alpha, background)
	alpha = type(alpha) == "string" and (tonumber(alpha, 16) / 0xff) or alpha
	local bg = rgb(background)
	local fg = rgb(foreground)
	local blendChannel = function(i)
		local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end
	return string.format("#%02x%02x%02x", blendChannel(1), blendChannel(2), blendChannel(3))
end

local function blend_bg(hex, amount, bg)
	return blend(hex, amount, bg or base_bg)
end

-- ===================================
-- Color hightlights
-- ===================================

local colors = {
	bg = "#222436",
	bg_dark = "#1e2030",
	bg_dark1 = "#191B29",
	bg_highlight = "#2f334d",
	blue = "#82aaff",
	blue0 = "#3e68d7",
	blue1 = "#65bcff",
	blue2 = "#0db9d7",
	blue5 = "#89ddff",
	blue6 = "#b4f9f8",
	blue7 = "#394b70",
	comment = "#636da6",
	cyan = "#86e1fc",
	dark3 = "#545c7e",
	dark5 = "#737aa2",
	fg = "#c8d3f5",
	fg_dark = "#828bb8",
	fg_gutter = "#3b4261",
	green = "#c3e88d",
	green1 = "#4fd6be",
	green2 = "#41a6b5",
	magenta = "#c099ff",
	magenta2 = "#ff007c",
	orange = "#ff966c",
	purple = "#fca7ea",
	red = "#ff757f",
	red1 = "#c53b53",
	teal = "#4fd6be",
	terminal_black = "#444a73",
	yellow = "#ffc777",
	git = {
		add = "#b8db87",
		change = "#7ca1f2",
		delete = "#e26a75",
	},
}

colors.none = "NONE"

colors.diff = {
	add = blend_bg(colors.green2, 0.25),
	delete = blend_bg(colors.red1, 0.25),
	change = blend_bg(colors.blue7, 0.15),
	text = colors.blue7,
}

colors.git.ignore = colors.dark3
colors.black = blend_bg(colors.bg, 0.8, "#000000")
colors.border_highlight = blend_bg(colors.blue1, 0.8)
colors.border = colors.black

colors.bg_popup = colors.none
colors.bg_statusline = colors.bg_dark

colors.bg_sidebar = colors.none
colors.bg_float = colors.none

colors.bg_visual = blend_bg(colors.blue0, 0.4)
colors.bg_search = colors.blue0
colors.fg_sidebar = colors.fg_dark
colors.fg_float = colors.fg

colors.error = colors.red1
colors.todo = colors.blue
colors.warning = colors.yellow
colors.info = colors.blue2
colors.hint = colors.teal

---@type table<string, vim.api.keyset.highlight>
local hightlights = {
	Foo = { bg = colors.magenta2, fg = colors.fg },
	Comment = { fg = colors.comment, italic = true },
	ColorColumn = { bg = colors.black },
	Conceal = { fg = colors.dark5 },
	Cursor = { fg = colors.bg, bg = colors.fg },
	lCursor = { fg = colors.bg, bg = colors.fg },
	CursorIM = { fg = colors.bg, bg = colors.fg },
	CursorColumn = { bg = colors.bg_highlight },
	CursorLine = { bg = colors.bg },
	Directory = { fg = colors.blue },
	DiffAdd = { bg = colors.diff.add },
	DiffChange = { bg = colors.diff.change },
	DiffDelete = { bg = colors.diff.delete },
	DiffText = { bg = colors.diff.text },
	EndOfBuffer = { fg = colors.bg },
	ErrorMsg = { fg = colors.error },
	VertSplit = { fg = colors.border },
	WinSeparator = { fg = colors.border, bold = true },
	Folded = { fg = colors.blue, bg = colors.bg_dark1 },
	FoldColumn = { bg = colors.none, fg = colors.comment },
	SignColumn = { bg = colors.none, fg = colors.fg_gutter },
	SignColumnSB = { bg = colors.bg_sidebar, fg = colors.fg_gutter },
	Substitute = { bg = colors.red, fg = colors.black },
	LineNr = { fg = colors.fg_gutter },
	CursorLineNr = { fg = colors.orange, bold = true },
	LineNrAbove = { fg = colors.fg_gutter },
	LineNrBelow = { fg = colors.fg_gutter },
	MatchParen = { fg = colors.orange, bold = true },
	ModeMsg = { fg = colors.fg_dark, bold = true },
	MsgArea = { fg = colors.fg_dark },
	MoreMsg = { fg = colors.blue },
	NonText = { fg = colors.dark3 },
	Normal = { fg = colors.fg, bg = colors.none },
	NormalNC = { fg = colors.fg, bg = colors.none },
	NormalSB = { fg = colors.fg_sidebar, bg = colors.bg_sidebar },
	NormalFloat = { fg = colors.fg_float, bg = colors.bg_float },
	FloatBorder = { fg = colors.border_highlight, bg = colors.bg_float },
	FloatTitle = { fg = colors.border_highlight, bg = colors.bg_float },
	Pmenu = { bg = colors.bg_popup, fg = colors.fg },
	PmenuMatch = { bg = colors.bg_popup, fg = colors.blue1 },
	PmenuSel = { bg = blend_bg(colors.fg_gutter, 0.8) },
	PmenuMatchSel = { bg = blend_bg(colors.fg_gutter, 0.8), fg = colors.blue1 },
	PmenuSbar = { bg = colors.bg_popup },
	PmenuThumb = { bg = colors.fg_gutter },
	Question = { fg = colors.blue },
	QuickFixLine = { bg = colors.bg_visual, bold = true },
	Search = { bg = colors.bg_search, fg = colors.fg },
	IncSearch = { bg = colors.orange, fg = colors.black },
	CurSearch = { bg = colors.orange, fg = colors.black },
	SpecialKey = { fg = colors.dark3 },
	SpellBad = { sp = colors.error, undercurl = true },
	SpellCap = { sp = colors.warning, undercurl = true },
	SpellLocal = { sp = colors.info, undercurl = true },
	SpellRare = { sp = colors.hint, undercurl = true },
	StatusLine = { fg = colors.fg, bg = colors.bg_statusline },
	StatusLineNC = { fg = colors.fg_gutter, bg = colors.bg_statusline },
	TabLine = { bg = colors.bg_statusline, fg = colors.fg_gutter },
	TabLineFill = { bg = colors.none },
	TabLineSel = { fg = colors.black, bg = colors.blue },
	Title = { fg = colors.blue, bold = true },
	Visual = { bg = colors.bg_visual },
	VisualNOS = { bg = colors.bg_visual },
	WarningMsg = { fg = colors.warning },
	Whitespace = { fg = colors.fg_gutter },
	WildMenu = { bg = colors.bg_visual },
	WinBar = { fg = colors.fg_sidebar, bg = colors.bg_statusline },
	WinBarNC = { fg = colors.fg_gutter, bg = colors.bg_statusline },

	Bold = { bold = true, fg = colors.fg },
	Character = { fg = colors.green },
	Constant = { fg = colors.orange },
	Debug = { fg = colors.orange },
	Delimiter = { fg = colors.blue1 },
	Error = { fg = colors.error },
	Function = { fg = colors.blue },
	Identifier = { fg = colors.green2 },
	Italic = { italic = true, fg = colors.fg },
	Keyword = { fg = colors.magenta, italic = true },
	Operator = { fg = colors.blue5 },
	PreProc = { fg = colors.cyan },
	Special = { fg = colors.blue1 },
	Statement = { fg = colors.purple },
	String = { fg = colors.green },
	Todo = { bg = colors.yellow, fg = colors.bg },
	Type = { fg = colors.blue1 },
	Underlined = { underline = true },
	debugBreakpoint = { bg = blend_bg(colors.info, 0.1), fg = colors.info },
	debugPC = { bg = colors.bg_sidebar },
	helpCommand = { bg = colors.terminal_black, fg = colors.blue },
	htmlH1 = { fg = colors.purple, bold = true },
	htmlH2 = { fg = colors.blue, bold = true },
	qfFileName = { fg = colors.blue },
	qfLineNr = { fg = colors.dark5 },

	LspReferenceText = { bg = colors.fg_gutter },
	LspReferenceRead = { bg = colors.fg_gutter },
	LspReferenceWrite = { bg = colors.fg_gutter },
	LspSignatureActiveParameter = { bg = blend_bg(colors.bg_visual, 0.4), bold = true },
	LspCodeLens = { fg = colors.comment },
	LspInlayHint = { bg = blend_bg(colors.blue7, 0.1), fg = colors.dark3 },
	LspInfoBorder = { fg = colors.border_highlight, bg = colors.bg_float },
	ComplHint = { fg = colors.terminal_black },

	DiagnosticError = { fg = colors.error },
	DiagnosticWarn = { fg = colors.warning },
	DiagnosticInfo = { fg = colors.info },
	DiagnosticHint = { fg = colors.hint },
	DiagnosticUnnecessary = { fg = colors.terminal_black },
	DiagnosticVirtualTextError = { bg = blend_bg(colors.error, 0.1), fg = colors.error },
	DiagnosticVirtualTextWarn = { bg = blend_bg(colors.warning, 0.1), fg = colors.warning },
	DiagnosticVirtualTextInfo = { bg = blend_bg(colors.info, 0.1), fg = colors.info },
	DiagnosticVirtualTextHint = { bg = blend_bg(colors.hint, 0.1), fg = colors.hint },
	DiagnosticUnderlineError = { undercurl = true, sp = colors.error },
	DiagnosticUnderlineWarn = { undercurl = true, sp = colors.warning },
	DiagnosticUnderlineInfo = { undercurl = true, sp = colors.info },
	DiagnosticUnderlineHint = { undercurl = true, sp = colors.hint },

	healthError = { fg = colors.error },
	healthSuccess = { fg = colors.green1 },
	healthWarning = { fg = colors.warning },

	diffAdded = { bg = colors.diff.add, fg = colors.git.add },
	diffRemoved = { bg = colors.diff.delete, fg = colors.git.delete },
	diffChanged = { bg = colors.diff.change, fg = colors.git.change },
	diffOldFile = { fg = colors.blue1, bg = colors.diff.delete },
	diffNewFile = { fg = colors.blue1, bg = colors.diff.add },
	diffFile = { fg = colors.blue },
	diffLine = { fg = colors.comment },
	diffIndexLine = { fg = colors.magenta },
	helpExample = { fg = colors.comment },
}

for group, opt in pairs(hightlights) do
	vim.api.nvim_set_hl(0, group, opt)
end
