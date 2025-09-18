return {

  "hrsh7th/nvim-cmp",

  dependencies = {

    "L3MON4D3/LuaSnip",

    "saadparwaiz1/cmp_luasnip",

    "hrsh7th/cmp-nvim-lsp",

    "hrsh7th/cmp-buffer",

    "hrsh7th/cmp-path",

    "rafamadriz/friendly-snippets",
  },

  config = function()
    local cmp = require("cmp")

    local luasnip = require("luasnip")

    cmp.setup({

      snippet = {

        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({

        ["<C-b>"] = cmp.mapping.scroll_docs(-4),

        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        ["<C-Space>"] = cmp.mapping.complete(),

        ["<C-e>"] = cmp.mapping.abort(),

        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),

      sources = cmp.config.sources({

        { name = "nvim_lsp" },

        { name = "luasnip" },

        { name = "buffer" },

        { name = "path" },
      }),
    })

    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
