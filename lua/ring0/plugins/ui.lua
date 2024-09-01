return {
	-- {
	-- 	"rose-pine/neovim",
  -- "catppuccin/nvim",
	-- },
	{
		"blazkowolf/gruber-darker.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			vim.cmd.colorscheme("gruber-darker")
		end,
	},
	-- {
	-- 	"catppuccin",
	-- 	opts = {
	-- 		transparent_background = true,
	-- 	},
	-- },
	-- { -- Highlight todo, notes, etc in comments
	-- 	"folke/todo-comments.nvim",
	-- 	event = "VimEnter",
	-- 	dependencies = { "nvim-lua/plenary.nvim" },
	-- 	opts = { signs = true },
	-- },
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
