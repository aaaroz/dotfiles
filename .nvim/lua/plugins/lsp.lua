return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"cssls",
					"html",
					"emmet_ls",
					"ts_ls",
					"gopls",
					"svelte",
					"tailwindcss",
					"efm",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
			lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true

			---@diagnostic disable-next-line: unused-local
			local on_attach = function(bufnr, client)
				local opts = { noremap = true, silent = true }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

				-- code actions
				vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

				vim.keymap.set("n", "<C-p>", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "<A-p>", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				vim.keymap.set("n", "<C-K>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set("n", "<leader>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
			end
			local function eslint_config_exists()
				local eslintrc = vim.fn.glob(".eslint.config.*", 0, 1)

				if not vim.tbl_isempty(eslintrc) then
					return true
				end

				if vim.fn.filereadable("package.json") then
					if vim.fn.json_decode(vim.fn.readfile("package.json"))["eslintConfig"] then
						return true
					end
				end

				return false
			end

			lspconfig.emmet_ls.setup({
				capabilities = lsp_capabilities,
				filetypes = {
					"css",
					"html",
					"javascript",
					"javascriptreact",
					"sass",
					"scss",
					"svelte",
					"typescriptreact",
				},
				init_options = {
					html = {
						options = {
							["bem.enabled"] = true,
						},
					},
				},
				on_attach = on_attach,
			})

			local eslint = {
				lintCommand = "eslint_d -f unix --stdin --stdin-filename ${INPUT}",
				lintStdin = true,
				lintFormats = { "%f:%l:%c: %m" },
				lintIgnoreExitCode = true,
				formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
				formatStdin = true,
			}

			lspconfig.efm.setup({
				capabilities = lsp_capabilities,
				on_attach = on_attach,
				root_dir = function()
					if not eslint_config_exists() then
						return nil
					end
					return vim.fn.getcwd()
				end,
				settings = {
					languages = {
						javascript = { eslint },
						javascriptreact = { eslint },
						["javascript.jsx"] = { eslint },
						typescript = { eslint },
						["typescript.tsx"] = { eslint },
						typescriptreact = { eslint },
					},
				},
				filetypes = {
					"javascript",
					"javascriptreact",
					"javascript.jsx",
					"typescript",
					"typescript.tsx",
					"typescriptreact",
				},
			})

			lspconfig.html.setup({
				capabilities = lsp_capabilities,
				on_attach = on_attach,
			})
			lspconfig.cssls.setup({
				capabilities = lsp_capabilities,
				on_attach = on_attach,
			})

			lspconfig.lua_ls.setup({
				capabilities = lsp_capabilities,
				on_attach = on_attach,
			})

			lspconfig.ts_ls.setup({
				capabilities = lsp_capabilities,
				on_attach = on_attach,
			})

			lspconfig.svelte.setup({
				capabilities = lsp_capabilities,
				on_attach = on_attach,
			})

			lspconfig.gopls.setup({
				capabilities = lsp_capabilities,
				on_attach = on_attach,
			})

			lspconfig.tailwindcss.setup({
				capabilities = lsp_capabilities,
				on_attach = on_attach,
			})
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
		ft = "rust",
		config = function()
			local mason_registry = require("mason-registry")
			local codelldb = mason_registry.get_package("codelldb")
			local extension_path = codelldb:get_install_path() .. "/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
			-- If you are on Linux, replace the line above with the line below:
			-- local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
			local cfg = require("rustaceanvim.config")

			vim.g.rustaceanvim = {
				dap = {
					adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
				},
			}
		end,
	},
	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},

	{
		"mfussenegger/nvim-dap",
		config = function()
			local mason_registry = require("mason-registry")
			local codelldb = mason_registry.get_package("codelldb")
			local extension_path = codelldb:get_install_path() .. "/extension/"
			local codelldb_path = extension_path .. "adapter/codelldb"
			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			dap.adapters.codelldb = {
				type = "server",
				port = "${port}",
				executable = {
					-- Change this to your path!
					command = codelldb_path,
					args = { "--port", "${port}" },
				},
			}

			dap.configurations.rust = {
				{
					name = "Launch file",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			require("dapui").setup()
		end,
	},

	{
		"saecki/crates.nvim",
		ft = { "toml" },
		config = function()
			require("crates").setup({
				completion = {
					cmp = {
						enabled = true,
					},
				},
			})
			require("cmp").setup.buffer({
				sources = { { name = "crates" } },
			})
		end,
	},
}
