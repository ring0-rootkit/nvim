return { -- Fuzzy Finder (files, lsp, etc)
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",

			build = "make",

			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-telescope/telescope-ui-select.nvim" },

		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		local builtin = require("telescope.builtin")
		map("n", "<leader>sh", builtin.help_tags)
		map("n", "<leader>sk", builtin.keymaps)
		map("n", "<leader>sf", builtin.find_files)
		map("n", "<leader>ss", builtin.builtin)
		map("n", "<leader>sw", builtin.grep_string)
		map("n", "<leader>sg", builtin.live_grep)
		map("n", "<leader>sd", builtin.diagnostics)
		map("n", "<leader><leader>", builtin.buffers)

		map("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end)
	end,
}
