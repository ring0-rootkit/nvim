return {
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	{ "numToStr/Comment.nvim", opts = {} },

	{ -- Fuzzy Finder (files, lsp, etc)
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
	},

	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
				callback = function(event)
					map("n", "gd", require("telescope.builtin").lsp_definitions)
					map("n", "gr", require("telescope.builtin").lsp_references)
					map("n", "gI", require("telescope.builtin").lsp_implementations)
					map("n", "<leader>D", require("telescope.builtin").lsp_type_definitions)
					map("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols)
					map("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols)
					map("n", "<leader>rn", vim.lsp.buf.rename)
					map("n", "<leader>ca", vim.lsp.buf.code_action)
					map("n", "K", vim.lsp.buf.hover)
					map("n", "gD", vim.lsp.buf.declaration)
					map("n", "<leader>ee", "oif err != nil {<CR>}<esc>ko")
					map("i", "<C-space>", "<C-x><C-o>")
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()

			require("mason").setup()

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = {}
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},

	{ -- Autoformat
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
			},
		},
	},
	{
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
	},
	{
		"akinsho/git-conflict.nvim",
		version = "*",
		config = { default_mappings = false },
		init = function()
			map("n", "[x", ":GitConflictPrevConflict<CR>")
			map("n", "]x", ":GitConflictNextConflict<CR>")
		end,
	},
}
