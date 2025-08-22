require("ring0")

-- [[ Basic Autocommands ]]
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

-- vim.cmd(":syntax off")
vim.cmd(':highlight Statement   ctermfg=yellow')     -- any statement
vim.cmd(':highlight Conditional ctermfg=yellow')   -- if, then, else, endif, switch, etc.
vim.cmd(':highlight Repeat      ctermfg=yellow')        -- for, do, while, etc.
vim.cmd(':highlight Label       ctermfg=yellow')         -- case, default, etc.
vim.cmd(':highlight Keyword     ctermfg=yellow')       -- any other keyword
vim.cmd(':highlight Exception   ctermfg=yellow')     -- try, catch, throw
