return {
	-- LSP Configuration & Plugins
	"neovim/nvim-lspconfig",
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for Neovim
		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
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
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				client.server_capabilities.semanticTokensProvider = nil
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
				border = border,
				source = "always",
				header = "",
				prefix = "",
			},
		})

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
		capabilities.textDocument.completion.completionItem.snippetSupport = false
		capabilities.signatureHelpProvider = false

		capabilities.semanticTokensProvider = nil

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
						-- analyses = {
						-- 	fieldalignment = true,
						-- 	nilness = true,
						-- 	unusedparams = true,
						-- 	unusedwrite = true,
						-- 	useany = true,
						-- },
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
			"stylua", -- Used to format Lua code
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
	end,
}
