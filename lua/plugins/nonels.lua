return {

  "nvimtools/none-ls.nvim",

  dependencies = { "nvim-lua/plenary.nvim" },

  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({

      sources = {

        null_ls.builtins.formatting.stylua,

        null_ls.builtins.formatting.goimports,

        null_ls.builtins.formatting.gofmt,

        null_ls.builtins.formatting.prettier.with({
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
          },
        }),

        null_ls.builtins.diagnostics.golangci_lint,
      },

      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("LspFormatting", {}),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    })
  end,
}
