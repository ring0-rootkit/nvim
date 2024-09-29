return {
	{
		"catppuccin/nvim",
		"blazkowolf/gruber-darker.nvim",
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
		end,
		init = function()
			vim.cmd.colorscheme("gruber-darker")
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
