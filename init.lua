vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = false
vim.opt.splitbelow = false
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.completeopt = "menuone,noinsert,noselect,popup,fuzzy"
vim.o.termguicolors = true

vim.wo.wrap = false
vim.o.sidescroll=5

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
	vim.lsp.handlers.hover, { border = "rounded", title = "Never gonna give you up..." }
)

local map = function(mode, keystroke, opts)
	vim.keymap.set(mode, keystroke, opts)
end

-- [[ Basic Keymaps ]]
vim.opt.hlsearch = true
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "<leader>e", vim.diagnostic.open_float)

map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "<leader>b", ":Gitblame<CR>")

-- [[ Basic Autocommands ]]
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
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

	{ -- Highlight todo, notes, etc in comments
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = true },
	},
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
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
	{
		"ring0-rootkit/gitblame.nvim",
		opts = {},
	},
		"ring0-rootkit/ring0-light.nvim",
	{
		"ring0-rootkit/ring0-dark.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			vim.cmd.colorscheme("ring0dark")
		end,
	},
})
