-- [[ Basic Keymaps ]]
local wk = require('which-key')

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
wk.register({
  ['<leader>d'] = { name = '+[D]iagnostics' },
  ['<leader>d['] = { vim.diagnostic.goto_prev, 'Go to previous diagnostic message' },
  ['<leader>d]'] = { vim.diagnostic.goto_next, 'Go to next diagnostic message' },
  ['<leader>de'] = { vim.diagnostic.open_float, 'Open floating diagnostic message' },
  ['<leader>dq'] = { vim.diagnostic.setloclist, 'Open diagnostics list' },
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

vim.keymap.set('n', '<leader>xl', '<cmd>lopen<cr>', { desc = 'Location List' })
vim.keymap.set('n', '<leader>xq', '<cmd>copen<cr>', { desc = '[Q]uickfix List' })
vim.keymap.set('n', '[q', vim.cmd.cprev, { desc = 'Previous quickfix' })
vim.keymap.set('n', ']q', vim.cmd.cnext, { desc = 'Next quickfix' })

-- Buffer
wk.register({
  ['<leader>b'] = { name = '+[B]uffer' },
  ['<leader>bh'] = { ':TSBufEnable highlight<cr>', '[H]ighlight enabled' },
  ['<S-h>'] = { ':bprevious<cr>', 'Previous buffer' },
  ['<S-l>'] = { ':bnext<cr>', 'Next buffer' },
})

-- File
wk.register({
  ['<leader>f'] = { name = '+[F]iles' },
  ['<leader>fn'] = { ':enew<cr>', '[N]ew File' },
  ['<leader>ff'] = { vim.lsp.buf.format, '[F]ormat [F]ile' },
  ['<leader>fp'] = { ':Prettier<cr>', '[F]ormat with [P]rettier' },
  -- See `:help telescope.builtin`
  ['<leader>fr'] = { ':Telescope oldfiles<cr>', '[F]ind [R]ecent files' },
  ['<leader>fg'] = { ':Telescope git_files<cr>', '[F]ind [G]it files' },
})
-- save file
vim.keymap.set({ 'i', 'x', 'n', 's' }, '<C-s>', '<cmd>w<cr><esc>', { desc = 'Save file' })

-- Search
wk.register({
  ['<leader>s'] = { name = '+[S]earch' },
  ['<leader>sf'] = { ':Telescope find_files<cr>', '[S]earch [F]iles' },
  ['<leader>sh'] = { ':Telescope help_tags<cr>', '[S]earch [H]elp' },
  ['<leader>sw'] = { ':Telescope grep_string<cr>', '[S]earch [W]ord' },
  ['<leader>sg'] = { ':Telescope live_grep<cr>', '[S]earch [G]rep' },
  ['<leader>sd'] = { ':Telescope diagnostics<cr>', '[S]earch [D]iagnostics' },
  ['<leader>sr'] = { ':Telescope resume<cr>', '[S]earch [R]esume' },
})

-- LSP
-- See `:help vim.lsp.*` for documentation on the below functions
wk.register({
  ['<leader>l'] = { name = '+[L]SP' },
  ['<leader>lk'] = { vim.lsp.buf.hover, 'Diagnostics pop-up' },
  ['<leader>ld'] = { vim.lsp.buf.definition, '[D]efinition' },
  ['<leader>lr'] = { vim.lsp.buf.references, '[R]eferences' },
  ['<leader>lc'] = { vim.lsp.buf.code_action, '[C]ode action' },
})

-- Neotree
wk.register({
  ['<leader>n'] = { name = '+[N]eotree' },
  ['<leader>nn'] = { ':Neotree filesystem reveal left<cr>', '[O]pen Neotree' },
  ['<leader>nb'] = { ':Neotree buffers reveal float<cr>', 'Neotree [b]uffers' },
})
