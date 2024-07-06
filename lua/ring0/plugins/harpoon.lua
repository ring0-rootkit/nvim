return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	init = function()
		local harpoon = require("harpoon")
		harpoon:setup()
		map("n", "<leader>ja", function()
			harpoon:list():add()
		end)
		map("n", "<leader>je", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		map("n", "<C-h>", function()
			harpoon:list():prev()
		end)
		map("n", "<C-i>", function()
			harpoon:list():next()
		end)
	end,
	dependencies = { "nvim-lua/plenary.nvim" },
}
