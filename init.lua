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
vim.o.omnifunc = "v:lua.vim.lsp.omnifunc"

vim.o.foldmethod = "marker"
vim.o.foldlevel = 0

vim.o.completeopt = "menuone,noinsert,noselect,popup"
vim.o.termguicolors = true

vim.opt.colorcolumn = "81"

vim.o.winborder = "rounded"

vim.wo.wrap = true

vim.opt.laststatus = 2
vim.opt.statusline = " %f %m %= %l:%c ♥ "

vim.opt.hlsearch = true
vim.opt.switchbuf = 'useopen'
-- }}}
-- OTHER {{{
vim.cmd [[
	"syntax on
	"highlight Statement   ctermfg=Yellow
	"highlight Conditional ctermfg=Yellow
	"highlight Repeat      ctermfg=Yellow
	"highlight Label       ctermfg=Yellow
	"highlight Keyword     ctermfg=Yellow
	"highlight Exception   ctermfg=Yellow
]]

_G.map = function(mode, keystroke, opts)
	vim.keymap.set(mode, keystroke, opts)
end
-- }}}
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

-- }}}
-- PLUGINS {{{
vim.pack.add({
	"https://github.com/ring0-rootkit/omarchy-neovim-colortheme",
	"https://github.com/catppuccin/nvim",

	"https://github.com/tpope/vim-sleuth",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
	"https://github.com/nvim-telescope/telescope-ui-select.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/nvim-telescope/telescope.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/ring0-rootkit/gitblame.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/hrsh7th/nvim-cmp",
	"https://github.com/hrsh7th/cmp-nvim-lsp",
	"https://github.com/hrsh7th/cmp-path",
	"https://github.com/onsails/lspkind.nvim",
	"https://github.com/xiyaowong/transparent.nvim",
	"https://github.com/folke/zen-mode.nvim",

	"https://github.com/nvim-treesitter/nvim-treesitter",
	"https://github.com/rafaelsq/nvim-goc.lua",
})

require("gitblame").setup()
require("mason").setup()
require("oil").setup()
require("telescope").setup({
	defaults = {
		prompt_prefix = "",
		entry_prefix = " ",
		selection_caret = "> ",
		path_display = { "smart" },
		layout_config = {
			prompt_position = "top",
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
-- }}}
-- go-test-cov {{{
local goc = require'nvim-goc'
goc.setup({ verticalSplit = false })

vim.keymap.set('n', '<Leader>gf', function() goc.Coverage() end, {silent=true})
vim.keymap.set('n', '<Leader>gt', function() goc.CoverageFunc() end, {silent=true})
vim.keymap.set('n', '<Leader>gc', goc.ClearCoverage, {silent=true})

cf = function(testCurrentFunction)
  local cb = function(path, index)
    if path then
      vim.cmd(":silent exec \"!xdg-open file://" .. path .. "\\\\#file" .. index .. "\"")
    end
  end

  if testCurrentFunction then
    goc.CoverageFunc(nil, cb, 0)
  else
    goc.Coverage(nil, cb)
  end
end

vim.keymap.set('n', '<leader>ga', cf, {silent=true})
vim.keymap.set('n', '<Leader>gb', function() cf(true) end, {silent=true})
-- }}}
--{{{THEME

-- DEFAULT THEME
require('catppuccin').setup({
	color_overrides = {
		latte = { text = "#000000" },
		mocha = { text = "#CDD6F4" },
	},
	highlight_overrides = {
		latte = function(latte)
			local h = {}

			local groups = vim.fn.getcompletion("", "highlight")

			for _, group in ipairs(groups) do
				local name = group:lower()

				if name:find("comment") then
					h[group] = { fg = latte.overlay2, style = { "italic" } }
				elseif name:find("string") then
					h[group] = { fg = latte.green }
				else
					h[group] = { fg = "#000000" }
				end
			end

			return h
		end,
		_latte = function(latte)
			return {
				Statement = { fg = latte.yellow },
				Conditional = { fg = latte.yellow },
				Repeat = { fg = latte.yellow },
				Label = { fg = latte.yellow },
				Keyword = { fg = latte.yellow },
				Exception = { fg = latte.yellow },
			}
		end,
		-- mocha = function(mocha)
		-- 	return {
		-- 		Statement = { fg = mocha.yellow },
		-- 		Conditional = { fg = mocha.yellow },
		-- 		Repeat = { fg = mocha.yellow },
		-- 		Label = { fg = mocha.yellow },
		-- 		Keyword = { fg = mocha.yellow },
		-- 		Exception = { fg = mocha.yellow },
		-- 	}
		-- end,
	},
})

vim.cmd(":colorscheme catppuccin")

-- LOAD OMARCHY THEME
-- require("omarchy-neovim-colortheme").setup()

--}}}
-- COMPLETION {{{
local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	completion = { autocomplete = false, completeopt = "menuone,noinsert,fuzzy" },
	window = { completion = { border = "rounded" }, documentation = { border = "rounded" } },
	preselect = false,

	mapping = cmp.mapping.preset.insert({
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),

		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),

		["<CR>"] = cmp.mapping.confirm({ select = false }),

		-- If you prefer more traditional completion keymaps,
		-- you can uncomment the following lines
		--['<CR>'] = cmp.mapping.confirm { select = true },
		--['<Tab>'] = cmp.mapping.select_next_item(),
		--['<S-Tab>'] = cmp.mapping.select_prev_item(),

		["<C-Space>"] = cmp.mapping.complete({}),
	}),
	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
		{ name = "supermaven" },
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol", -- show only symbol annotations
			maxwidth = {
				menu = 50, -- leading text (labelDetails)
				abbr = 50, -- actual suggestion item
			},
			ellipsis_char = "...",
			show_labelDetails = true,
			symbol_map = { Supermaven = "" },
		}),
	},
})
-- }}}
-- LSP {{{
-- LSP Configuration & Plugins
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
		map("n", "<C-k>", vim.lsp.buf.signature_help)
		map("n", "gD", vim.lsp.buf.declaration)
		map("n", "<leader>ee", "oif err != nil {<CR>}<esc>ko")

		-- disable syntax highlighting
		-- local client = vim.lsp.get_client_by_id(event.data.client_id)
		-- client.server_capabilities.semanticTokensProvider = nil
	end,
})

-- local border = "rounded"

-- LSP settings (for overriding per client)
-- local handlers = {
-- 	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
-- 	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
-- }

-- require("lspconfig.ui.windows").default_options = {
-- 	border = border,
-- }

vim.diagnostic.config({
	-- update_in_insert = true,
	float = {
		focusable = false,
		style = "minimal",
		source = "always",
		header = "",
		prefix = "",
	},
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = false
capabilities.signatureHelpProvider = false

-- capabilities.semanticTokensProvider = nil

local servers = {
	-- clangd = {},
	gopls = {
		settings = {
			gopls = {
				hints = {
					assignVariableTypes = true,
					compositeLiteralFields = true,
					compositeLiteralTypes = true,
					constantValues = true,
					functionTypeParameters = true,
					parameterNames = true,
					rangeVariableTypes = true,
				},
				analyses = {
					fieldalignment = true,
					nilness = true,
					unusedparams = true,
					unusedwrite = true,
					useany = true,
				},
				codelenses = {
					gc_details = false,
					generate = true,
					regenerate_cgo = true,
					run_govulncheck = true,
					test = true,
					tidy = true,
					upgrade_dependency = true,
					vendor = true,
				},
			},
		},
	},
	rust_analyzer = {},
	ts_ls = {},
	zls = {
		settings = {
			zls = {
				enable_inlay_hints = true,
				enable_snippets = true,
				inlay_hints_show_variable_type_hints = true,
				inlay_hints_show_struct_literal_field_type = true,
				inlay_hints_show_parameter_name = true,
				inlay_hints_show_builtin = true,
				warn_style = true,

				inlay_hints_exclude_single_argument = false,
				enable_argument_placeholders = false,
			},
		},
	},

	lua_ls = {
		settings = {
			Lua = {
				completion = {
					callSnippet = "Replace",
				},
				diagnostics = { disable = { "missing-fields" } },
			},
		},
	},
}
require("mason").setup()

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
	"stylua",
})
require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("mason-lspconfig").setup({
	handlers = {
		function(server_name)
			local server = servers[server_name] or {}
			server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
			server.handlers = handlers
			require("lspconfig")[server_name].setup(server)
		end,
	},
})
--}}}
