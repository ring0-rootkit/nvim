return {
	{
		"catppuccin/nvim",
		"ring0-rootkit/ring0-light.nvim",
	},
	{
		"rose-pine/neovim",
		priority = 1000,
		config = function()
			require("rose-pine").setup({
				styles = {
					transparency = true,
				},
			})
			require("catppuccin").setup({
				transparent_background = true, -- disables setting the background color.
			})

			-- setup must be called before loading
			vim.cmd.colorscheme("catppuccin")
		end,
		init = function()
			vim.cmd.colorscheme("catppuccin-latte")
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
