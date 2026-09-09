-- installed via lua/custom/plugins/init.lua (vim.g.barbar_auto_setup is also
-- set there, since it must be set before barbar.nvim's plugin/ files load)
vim.keymap.set('n', '<Tab>', '<Cmd>BufferNext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>xx', '<Cmd>BufferClose<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>xl', '<Cmd>BufferCloseBuffersRight<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>xh', '<Cmd>BufferCloseBuffersLeft<CR>', { noremap = true, silent = true })

require('barbar').setup {
  animation = true,
}
