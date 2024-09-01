return {
	-- {
	-- 	"rose-pine/neovim",
	-- "blazkowolf/gruber-darker.nvim",
	-- },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			vim.cmd.colorscheme("catppuccin-latte")
		end,
	},
	{
		"catppuccin",
		opts = {
			transparent_background = true,
		},
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
