vim.pack.add { 'https://github.com/numToStr/Comment.nvim' }
require('Comment').setup()

vim.keymap.set('n', '<leader>/', function() require('Comment.api').toggle.linewise.current() end, { desc = 'comment toggle' })
vim.keymap.set('v', '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = 'comment toggle' })
