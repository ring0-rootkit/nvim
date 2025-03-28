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

			defaults = {
				-- These three settings are optional, but recommended.
				prompt_prefix = "",
				entry_prefix = " ",
				selection_caret = "> ",
				path_display = { "smart" },

				-- This is the important part: without this, Telescope windows will look a
				-- bit odd due to how borders are highlighted.
				-- layout_strategy = "grey",
				layout_config = {
					-- The extension supports both "top" and "bottom" for the prompt.
					prompt_position = "top",

					-- You can adjust these settings to your liking.
					-- width = 0.6,
					-- height = 0.5,
					-- preview_width = 0.6,
				},
			},
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
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown())
		end)
	end,
}
