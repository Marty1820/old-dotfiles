return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ':TSUpdate',
    config = function()
      local config = require('nvim-treesitter.configs')
      config.setup({
        ensure_installed = {
          'bash',
          'html',
          'javascript',
          'json',
          'json5',
          'jsonc',
          'lua',
          'luadoc',
          'luap',
          'markdown',
          'markdown_inline',
          'python',
          'vim',
          'vimdoc',
          'yaml',
          'yuck',
        },
        auto_install = true,
        highlight = { enabled = true },
        indent = { enable = true },
      })
    end,
  },
}
