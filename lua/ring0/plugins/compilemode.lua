return {
	"ring0-rootkit/compile-mode.nvim",
	config = function()
		local compile = require("compile-mode")
		compile.setup()
		vim.keymap.set("n", "<leader>c", compile.compile_setup)
		vim.keymap.set("n", "<leader>r", compile.compile)
	end,
}
