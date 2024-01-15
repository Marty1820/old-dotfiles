return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  config = function()
    -- require'alpha'.setup(require'alpha.themes.startify'.config)
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')

    -- Set header
    dashboard.section.header.val = {
      '                                                     ',
      '    ███╗░░░███╗░█████╗░██████╗░████████╗██╗░░░██╗    ',
      '    ████╗░████║██╔══██╗██╔══██╗╚══██╔══╝╚██╗░██╔╝    ',
      '    ██╔████╔██║███████║██████╔╝░░░██║░░░░╚████╔╝░    ',
      '    ██║╚██╔╝██║██╔══██║██╔══██╗░░░██║░░░░░╚██╔╝░░    ',
      '    ██║░╚═╝░██║██║░░██║██║░░██║░░░██║░░░░░░██║░░░    ',
      '    ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░░░╚═╝░░░    ',
      '                                                     ',
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button('e', '󰈔 > New file', ':ene <BAR> startinsert <CR>'),
      dashboard.button('f', '󰈞 > Find file', ':Telescope find_files<CR>'),
      dashboard.button('r', '󰤘 > Recent Files', ':Telescope oldfiles<CR>'),
      dashboard.button('s', '󱁻 > Settings', ':e $MYVIMRC | :cd %:p:h<CR>'),
      dashboard.button('l', '󰂓 > LazyVim', ':Lazy<CR>'),
      dashboard.button('q', '󰗼 > Quit NVIM', ':qa<CR>'),
    }

    -- Send config to alpha
    alpha.setup(dashboard.opts)
  end,
}
