-- gitsigns.nvim is already installed by the core setup; devicons dependency
-- is covered by mini.icons' devicons compat shim
vim.g.barbar_auto_setup = false

vim.pack.add { { src = 'https://github.com/romgrk/barbar.nvim', version = '53b5a2f34b68875898f0531032fbf090e3952ad7' } }

vim.keymap.set('n', '<Tab>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>xx', '<Cmd>BufferClose<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>xl', '<Cmd>BufferCloseBuffersRight<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>xh', '<Cmd>BufferCloseBuffersLeft<CR>', { noremap = true, silent = true })

require('barbar').setup {
  animation = true,
}
