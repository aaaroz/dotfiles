return {
	{
		"MeanderingProgrammer/dashboard.nvim",
		event = "VimEnter",
		config = function()
			local logo = {
				[[  █████╗  █████╗  █████╗ ██████╗  ██████╗ ███████╗]],
				[[  ██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔═══██╗╚══███╔╝ ]],
				[[  ███████║███████║███████║██████╔╝██║   ██║  ███╔╝ ]],
				[[  ██╔══██║██╔══██║██╔══██║██╔══██╗██║   ██║ ███╔╝  ]],
				[[  ██║  ██║██║  ██║██║  ██║██║  ██║╚██████╔╝███████╗ ]],
				[[  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝]],
			}

			require("dashboard").setup({
				header = logo,
				date_format = "%Y-%m-%d %H:%M:%S",
				directories = {
					"~/Documents/",
					"~/AppData/Local/nvim/",
					"~/OneDrive/Documents/Projects/pkm/",
					"~/OneDrive/Documents/Projects/skye/",
				},
				footer = {
					"Happy Coding 🚀",
				},
			})
		end,
	},
}
