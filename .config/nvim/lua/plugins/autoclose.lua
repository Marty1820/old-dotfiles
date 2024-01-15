return {
  'm4xshen/autoclose.nvim',
  config = function()
    require('autoclose').setup({
      pair_spaces = true,
    })
  end,
}
