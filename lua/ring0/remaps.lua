_G.map = function(mode, keystroke, opts)
	vim.keymap.set(mode, keystroke, opts)
end

_G.wrap = function(mode)
	vim.wo.wrap = mode
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

--  use if to delete without saving to clipboard
map("n", "x", '"_x')
map("v", "x", '"_x')

map("v", "<leader>s(", "di()<Esc>P")
map("v", "<leader>s[", "di[]<Esc>P")
map("v", "<leader>s{", "di{}<Esc>P")
map("v", "<leader>s'", "di''<Esc>P")
map("v", '<leader>s"', 'di""<Esc>P')
map("v", "<leader>s`", "di``<Esc>P")
