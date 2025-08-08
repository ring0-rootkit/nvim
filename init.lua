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

local handle = io.popen("gsettings get org.gnome.desktop.interface color-scheme")
local result = handle:read("*a")
handle:close()
if result == "'prefer-light'\n" then
	vim.cmd("colorscheme catppuccin")
	vim.cmd(":syntax off")
else
	vim.cmd("colorscheme rose-pine")
end
