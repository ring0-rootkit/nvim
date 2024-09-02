return {
	{
		"catppuccin/nvim",
		"blazkowolf/gruber-darker.nvim",
	},
	{
		"rose-pine/neovim",
		-- name = "catppuccin",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			vim.cmd.colorscheme("rose-pine-main")
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
