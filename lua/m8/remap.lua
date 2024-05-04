vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })

-- Bind Esc to jj
-- vim.keymap.set('i', 'jj', '<Esc>')

-- close all buffers except of current
vim.keymap.set('n', '<leader>cc', '<Cmd>:%bd|e#<CR>')

vim.keymap.set('n', '<leader>e','<Cmd>NvimTreeToggle<CR>')

-- for more convinient formating
vim.keymap.set('v', '<','<gv')
vim.keymap.set('v', '>','>gv')

vim.keymap.set('n', '<leader>x',':! chmod +x %<CR>', { desc = 'Make currently oppened file executable' })

vim.filetype.add({ extension = { templ = "templ" } })
