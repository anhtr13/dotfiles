th.git = th.git or {}
th.git.untracked_sign = ""
th.git.deleted_sign = "✘"
require("git"):setup()
require("starship"):setup({
	config_file = "~/.config/starship/starship.toml", -- Default: nil
})
