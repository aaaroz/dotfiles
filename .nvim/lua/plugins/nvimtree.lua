---@diagnostic disable: unused-local
return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local config = {}

		config.select_prompts = true
		config.log = {}
		config.log.enable = true
		config.log.types = {}
		config.log.types.git = true

		config.diagnostics = {}
		config.diagnostics.enable = true
		config.diagnostics.show_on_dirs = false

		config.sort_by = "case_sensitive"
		config.sync_root_with_cwd = true
		config.open_on_tab = false

		config.actions = {}
		config.actions.use_system_clipboard = true

		config.view = {}
		config.view.adaptive_size = true
		config.view.side = "right"
		config.view.width = 25

		config.renderer = {}
		config.renderer.group_empty = true

		config.renderer.special_files = {
			"Cargo.toml",
			"Makefile",
			"CMakeLists.txt",
			"config.bash",
			"config.sh",
			"config",
			"README.md",
			"readme.md",
			"LICENSE",
			"DEVELOPMENT.md",
			"DEVELOPING.md",
			"package.json",
			".nvimrc",
		}
		config.renderer.highlight_git = true
		config.renderer.highlight_diagnostics = true
		config.renderer.highlight_opened_files = "all"
		config.renderer.highlight_modified = "all"
		config.renderer.highlight_bookmarks = "all"
		config.renderer.highlight_clipboard = "all"

		config.renderer.icons = {}
		config.renderer.icons.webdev_colors = true
		config.renderer.icons.git_placement = "after"
		config.renderer.icons.modified_placement = "after"
		config.renderer.icons.glyphs = {
			git = {
				-- Git style symbols
				unstaged = "U",
				staged = "A",
				unmerged = "M",
				renamed = "R",
				untracked = "?",
				deleted = "D",
				ignored = "!",
			},
		}

		config.filters = {}
		config.filters.dotfiles = false
		config.filters.custom = {}

		config.git = {}
		config.git.enable = true
		require("nvim-tree").setup(config)

		-- toggle file tree
		vim.keymap.set("n", "<C-b>", "<cmd> NvimTreeToggle <CR>", {})

		-- focus
		vim.keymap.set("n", "<leader>e", "<cmd> NvimTreeFocus <CR>", { noremap = true, silent = true })
	end,
}
