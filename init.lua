-- AUTOCOMMANDS {{{
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- disable auto continuation of comments on CR
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")

vim.api.nvim_create_autocmd("TermOpen", {
	group = vim.api.nvim_create_augroup("custom-term-open", {}),
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.scrolloff = 0

		vim.bo.filetype = "terminal"
	end,
})
-- }}}
-- SETS {{{
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
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.inccommand = "split"
vim.opt.cursorline = false
vim.opt.scrolloff = 10
vim.o.shiftwidth = 8
vim.o.tabstop = 8
vim.o.swapfile = false

vim.o.foldmethod = "marker"
vim.o.foldlevel = 0

vim.o.completeopt = "menuone,noinsert,noselect,popup"
vim.o.termguicolors = false

vim.opt.colorcolumn = "81"

vim.o.winborder = "rounded"

vim.wo.wrap = true

vim.opt.laststatus = 2
vim.opt.statusline = " %f %m %= %l:%c ♥ "

vim.opt.hlsearch = true
-- }}}

_G.map = function(mode, keystroke, opts)
	vim.keymap.set(mode, keystroke, opts)
end

-- REMAPS {{{

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
map("n", "<leader>e", vim.diagnostic.open_float)

map("v", "<", "<gv")
map("v", ">", ">gv")

-- map("n", "<C-d>", "<C-d>zz")
-- map("n", "<C-u>", "<C-u>zz")

map("n", "<leader>b", ":Gitblame<CR>")

--  use if to delete without saving to clipboard
map("n", "x", '"_x')
map("v", "x", '"_x')

-- paste over highlited text without saving to clipboard
map("v", "p", '"_xp')

map("v", "<leader>s(", "di()<Esc>P")
map("v", "<leader>s[", "di[]<Esc>P")
map("v", "<leader>s{", "di{}<Esc>P")
map("v", "<leader>s'", "di''<Esc>P")
map("v", '<leader>s"', 'di""<Esc>P')
map("v", "<leader>s`", "di``<Esc>P")

map("n", "<leader>ee", "oif err != nil {<CR>}<esc>ko")

map("t", "Esc", "<C-><C-n>")

-- folding
map("n", "<leader>o", ":foldopen<CR>")
map("n", "<leader>p", ":foldclose<CR>")
map("v", "<leader>w", ":fold<CR>")

map("t", "<esc><esc>", "<c-\\><c-n>")

map("n", "<leader>jk", function()
	vim.cmd("vsplit *compilation*")
	vim.bo.buftype = "nofile"
	vim.bo.bufhidden = "hide"
	vim.bo.swapfile = false
	vim.cmd("vertical wincmd R")
	vim.cmd("split")
	vim.cmd("vertical wincmd J")
	vim.cmd("vertical wincmd k")
	vim.cmd("vertical wincmd H")
	vim.cmd("vertical wincmd l")
	vim.cmd("vertical wincmd j")
	vim.cmd("resize 15")
	vim.cmd("terminal")
	vim.cmd("vertical wincmd h")
end)

-- }}}

-- PLUGINS {{{
vim.pack.add({
	"https://github.com/ring0-rootkit/compile-mode.nvim",
	"https://github.com/tpope/vim-sleuth",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/ring0-rootkit/gitblame.nvim",
})

compile = require("compile-mode")
compile.setup()
map("n", "<leader>c", compile.compile_setup)
map("n", "<leader>r", compile.compile)

require("gitblame").setup()
require("oil").setup()
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
})

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
