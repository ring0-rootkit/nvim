return {
	{
		"rose-pine/neovim",
		config = function()
			require("rose-pine").setup({
				highlight_groups = {
					StatusLine = { fg = "love", bg = "love", blend = 10 },
					StatusLineNC = { fg = "subtle", bg = "surface" },
					StatusLineTerm = { fg = "love", bg = "love", blend = 10 },
				},
				dark_variant = "moon",
				styles = {
					transparency = true,
				},
				palette = {
					moon = {
						text = "#e0e0e0",
					},
					dawn = {
						-- text = "#303030",
						-- surface = "#c0c0c0",
					},
				},
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				custom_highlights = function()
					return {
						StatusLine = { bg = "#ffbbff" },
						StatusLineNC = { bg = "#ffbbff" },
						StatusLineTerm = { bg = "#ffbbff" },
					}
				end,
				transparent_background = true,
				color_overrides = {
					mocha = {
						text = "#e0e0e0",
					},
					latte = {
						text = "#1e1b1a",
					},
				},
			})
		end,
	},

	{
		"shaunsingh/nord.nvim",
	},
}
