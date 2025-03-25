return {
	{
		"catppuccin/nvim",
		"blazkowolf/gruber-darker.nvim",
		"ring0-rootkit/ring0-light.nvim",
	},
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	opts = {},
	-- 	config = function()
	-- 		require("tokyonight").setup({
	-- 			transparent = true,
	-- 			styles = {
	-- 				sidebars = "transparent",
	-- 				floats = "transparent",
	-- 			},
	-- 		})
	-- 		vim.cmd.colorscheme("tokyonight")
	-- 	end,
	-- },
	{
		"rose-pine/neovim",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				styles = {
					transparency = true,
				},
				palette = {
					moon = { text = "#bfbebb", subtle = "#9f9e9b" },
					dawn = { text = "#000000", subtle = "#909090" },
				},
			})

			require("catppuccin").setup({
				transparent_background = true,
			})

			vim.cmd.colorscheme("rose-pine-moon")
		end,
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"ring0-rootkit/gitblame.nvim",
		opts = {},
	},
}
