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

--vim.cmd(":syntax off")
vim.cmd(':highlight Statement   ctermfg=LightRed')     -- any statement
vim.cmd(':highlight Conditional ctermfg=LightRed')   -- if, then, else, endif, switch, etc.
vim.cmd(':highlight Repeat      ctermfg=LightRed')        -- for, do, while, etc.
vim.cmd(':highlight Label       ctermfg=LightRed')         -- case, default, etc.
vim.cmd(':highlight Keyword     ctermfg=LightRed')       -- any other keyword
vim.cmd(':highlight Exception   ctermfg=LightRed')     -- try, catch, throw
