vim.pack.add { { src = 'https://github.com/numToStr/Comment.nvim', version = 'e30b7f2008e52442154b66f7c519bfd2f1e32acb' } }
require('Comment').setup()

vim.keymap.set('n', '<leader>/', function() require('Comment.api').toggle.linewise.current() end, { desc = 'comment toggle' })
vim.keymap.set('v', '<leader>/', "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", { desc = 'comment toggle' })
