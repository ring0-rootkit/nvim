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
vim.o.sidescroll = 5

vim.lsp.handlers["textDocument/hover"] =
	vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", title = "Never gonna give you up..." })
