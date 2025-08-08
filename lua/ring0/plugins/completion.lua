return { -- Autocompletion
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- "saadparwaiz1/cmp_luasnip",

		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"onsails/lspkind.nvim",
	},
	config = function()
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
				-- { name = "luasnip" },
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
	end,
}
