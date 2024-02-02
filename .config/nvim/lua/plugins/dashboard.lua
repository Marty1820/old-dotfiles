return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local logo = [[
      ███╗░░░███╗░█████╗░██████╗░████████╗██╗░░░██╗
      ████╗░████║██╔══██╗██╔══██╗╚══██╔══╝╚██╗░██╔╝
      ██╔████╔██║███████║██████╔╝░░░██║░░░░╚████╔╝░
      ██║╚██╔╝██║██╔══██║██╔══██╗░░░██║░░░░░╚██╔╝░░
      ██║░╚═╝░██║██║░░██║██║░░██║░░░██║░░░░░░██║░░░
      ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝░░░╚═╝░░░░░░╚═╝░░░
    ]]
    require('dashboard').setup({
      theme = 'hyper',
      config = {
        header = vim.split(logo, '\n'),
        project = { enable = false },
        shortcut = {
          {
            desc = '󰈔 > New file',
            action = 'ene <BAR> startinsert',
            key = 'e',
          },
          {
            desc = '󰈞 > Find file',
            action = 'Telescope find_files',
            key = 'f',
          },
          {
            desc = '󰤘 > Recent Files',
            action = 'Telescope oldfiles',
            key = 'r',
          },
          {
            desc = '󱁻 > Settings',
            action = 'e $MYVIMRC | :cd %:p:h',
            key = 's',
          },
          {
            desc = '󰂓 > LazyVim',
            action = 'Lazy',
            key = 'l',
          },
          {
            desc = '󰟾 > Mason',
            action = 'Mason',
            key = 'm',
          },
          {
            desc = '󰗼 > Quit',
            action = 'qa',
            key = 'q',
          },
        },
      },
    })
  end,
}
