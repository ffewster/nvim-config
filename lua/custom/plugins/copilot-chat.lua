-- plenary.nvim is already installed by the core telescope setup
vim.pack.add { { src = 'https://github.com/CopilotC-Nvim/CopilotChat.nvim', version = '004ced055d8db59561cfcddc5f141ccd8d5a033b' } }

vim.keymap.set('n', '<leader>ch', '<Cmd>CopilotChatToggle<CR>', { noremap = true, silent = true })

require('CopilotChat').setup {
  -- See Configuration section for options
  model = 'claude-sonnet-4.6',
}
