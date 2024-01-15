return {
  {
    'L3MON4D3/LuaSnip',
    lazy = false,
    dependencies = {
      'rafamadriz/friendly-snippets',
    },
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    lazy = false,
    config = true,
  },
  {
    'hrsh7th/nvim-cmp',
    lazy = false,
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        window = {
          documentation = cmp.config.window.bordered(),
          completion = cmp.config.window.bordered(),
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
        }, {
          { name = 'buffer' },
        }),
      })
    end,
  },
}
