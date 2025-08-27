_G.map = function(mode, keystroke, opts)
	vim.keymap.set(mode, keystroke, opts)
end

_G.wrap = function(mode)
	vim.wo.wrap = mode
end

vim.api.nvim_set_keymap("n", "<C-S-f>", "<C-f>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-S-f>", "<C-f>", { noremap = true, silent = true })

-- [[ Basic Keymaps ]]
vim.opt.hlsearch = true
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
