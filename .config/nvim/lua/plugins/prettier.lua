return {
  'MunifTanjim/prettier.nvim',
  dependencies = { 'neovim/nvim-lspconfig', 'nvimtools/none-ls.nvim' },
  config = function()
    local prettier = require('prettier')
    prettier.setup({
      bin = 'prettierd',
      filetypes = {
        'css',
        'graphql',
        'html',
        'javascript',
        'javascriptreact',
        'json',
        'less',
        'markdown',
        'scss',
        'typescript',
        'typescriptreact',
        'yaml',
      },
      cli_options = {
        bracket_spacing = true,
        single_quote = true,
      },
    })
  end,
}
