local harpoon = require("harpoon")

harpoon:setup()

vim.keymap.set("n", "<leader>ja", function() harpoon:list():add() end,
    { desc = "Add current file to harpoon list" })
vim.keymap.set("n", "<leader>je", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
    { desc = "Open harpoon window" })

vim.keymap.set("n", "<leader>j1", function() harpoon:list():select(1) end,
    { desc = "Go to 1 harpoon file" })
vim.keymap.set("n", "<leader>j2", function() harpoon:list():select(2) end,
    { desc = "Go to 2 harpoon file" })
vim.keymap.set("n", "<leader>j3", function() harpoon:list():select(3) end,
    { desc = "Go to 3 harpoon file" })
vim.keymap.set("n", "<leader>j4", function() harpoon:list():select(4) end,
    { desc = "Go to 4 harpoon file" })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-h>", function() harpoon:list():prev() end,
    { desc = "Go to prev harpoon file in the list" })
vim.keymap.set("n", "<C-l>", function() harpoon:list():next() end,
    { desc = "Go to next harpoon file in the list" })


