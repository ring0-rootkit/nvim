return {
	"akinsho/git-conflict.nvim",
	version = "*",
	config = { default_mappings = false },
	init = function()
		map("n", "[x", ":GitConflictPrevConflict<CR>")
		map("n", "]x", ":GitConflictNextConflict<CR>")
	end,
}
