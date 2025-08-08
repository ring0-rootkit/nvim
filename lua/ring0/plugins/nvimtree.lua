return {
	"nvim-tree/nvim-tree.lua",
	lazy = true,
	init = function()
		vim.keymap.set("n", "<leader>t", "<Cmd>NvimTreeToggle<CR>")
		require("nvim-tree").setup()
	end,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
}
