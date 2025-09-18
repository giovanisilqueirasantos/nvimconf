return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"mason-org/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"gopls",
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})

			local function on_attach(client, bufnr)
				local group = vim.api.nvim_create_augroup("LspFormatting_" .. client.name, { clear = true })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = group,
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ async = false, bufnr = bufnr })
					end,
				})
			end

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "lua",
				callback = function()
					vim.lsp.start({
						name = "lua_ls",
						cmd = { "lua-language-server" },
						capabilities = capabilities,
						on_attach = on_attach,
						settings = {
							Lua = {
								diagnostics = { globals = { "vim" } },
							},
						},
					})
				end,
			})

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "go",
				callback = function()
					vim.lsp.start({
						name = "gopls",
						cmd = { "gopls" },
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,
			})
		end,
	},
}
