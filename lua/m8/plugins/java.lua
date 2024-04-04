return {
    "mfussenegger/nvim-jdtls",
    dependencies = { "mfussenegger/nvim-dap", "neovim/nvim-lspconfig" },
    event = "VeryLazy",
    config = function()
      -- Autocmd
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "java" },
        callback = function()
          -- LSP capabilities
          local jdtls = require "jdtls"
          local capabilities = require("base.lsp.utils").capabilities()
          local extendedClientCapabilities = jdtls.extendedClientCapabilities
          extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

          local launcher, os_config, lombok = get_jdtls()
          local workspace_dir = get_workspace()
          local bundles = get_bundles()

          local on_attach = function(_, bufnr)
            vim.lsp.codelens.refresh()
            jdtls.setup_dap { hotcodereplace = "auto" }
            require("jdtls.dap").setup_dap_main_class_configs()
            require("jdtls.setup").add_commands()

            local map = function(mode, lhs, rhs, desc)
              if desc then
                desc = desc
              end
              vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
            end

            -- Register keymappings
            local wk = require "which-key"
            local keys = { mode = { "n", "v" }, ["<leader>lj"] = { name = "+Java" } }
            wk.register(keys)

            map("n", "<leader>ljo", jdtls.organize_imports, "Organize Imports")
            map("n", "<leader>ljv", jdtls.extract_variable, "Extract Variable")
            map("n", "<leader>ljc", jdtls.extract_constant, "Extract Constant")
            map("n", "<leader>ljt", jdtls.test_nearest_method, "Test Nearest Method")
            map("n", "<leader>ljT", jdtls.test_class, "Test Class")
            map("n", "<leader>lju", "<cmd>JdtUpdateConfig<cr>", "Update Config")
            map("v", "<leader>ljv", "<esc><cmd>lua require('jdtls').extract_variable(true)<cr>", "Extract Variable")
            map("v", "<leader>ljc", "<esc><cmd>lua require('jdtls').extract_constant(true)<cr>", "Extract Constant")
            map("v", "<leader>ljm", "<esc><Cmd>lua require('jdtls').extract_method(true)<cr>", "Extract Method")

            vim.api.nvim_create_autocmd("BufWritePost", {
              pattern = { "*.java" },
              callback = function()
                local _, _ = pcall(vim.lsp.codelens.refresh)
              end,
            })
          end

          local config = {
            cmd = {
              "java",
              "-Declipse.application=org.eclipse.jdt.ls.core.id1",
              "-Dosgi.bundles.defaultStartLevel=4",
              "-Declipse.product=org.eclipse.jdt.ls.core.product",
              "-Dlog.protocol=true",
              "-Dlog.level=ALL",
              "-Xms1g",
              "--add-modules=ALL-SYSTEM",
              "--add-opens",
              "java.base/java.util=ALL-UNNAMED",
              "--add-opens",
              "java.base/java.lang=ALL-UNNAMED",
              "-javaagent:" .. lombok,
              "-jar",
              launcher,
              "-configuration",
              os_config,
              "-data",
              workspace_dir,
            },
            root_dir = require("jdtls.setup").find_root { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" },
            capabilities = capabilities,
            on_attach = on_attach,

            settings = {
              java = {
                autobuild = { enabled = false },
                signatureHelp = { enabled = true },
                contentProvider = { preferred = "fernflower" },
                saveActions = {
                  organizeImports = true,
                },
                sources = {
                  organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                  },
                },
                codeGeneration = {
                  toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                  },
                  hashCodeEquals = {
                    useJava7Objects = true,
                  },
                  useBlocks = true,
                },
                eclipse = {
                  downloadSources = true,
                },
                configuration = {
                  updateBuildConfiguration = "interactive",
                  -- NOTE: Add the available runtimes here
                  -- https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
                  -- runtimes = {
                  --   {
                  --     name = "JavaSE-18",
                  --     path = "~/.sdkman/candidates/java/18.0.2-sem",
                  --   },
                  -- },
                },
                maven = {
                  downloadSources = true,
                },
                implementationsCodeLens = {
                  enabled = true,
                },
                referencesCodeLens = {
                  enabled = true,
                },
                references = {
                  includeDecompiledSources = true,
                },
                inlayHints = {
                  parameterNames = {
                    enabled = "all", -- literals, all, none
                  },
                },
                format = {
                  enabled = false,
                },
                -- NOTE: We can set the formatter to use different styles
                -- format = {
                --   enabled = true,
                --   settings = {
                --     url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
                --     profile = "GoogleStyle",
                --   },
                -- },
              },
            },
            init_options = {
              bundles = bundles,
              extendedClientCapabilities = extendedClientCapabilities,
            },
          }
          require("jdtls").start_or_attach(config)
          end,
    })
    end,
}
