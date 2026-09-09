-- plenary.nvim is already installed by the core telescope setup
vim.pack.add { 'https://github.com/CopilotC-Nvim/CopilotChat.nvim' }

vim.keymap.set('n', '<leader>ch', '<Cmd>CopilotChatToggle<CR>', { noremap = true, silent = true })

require('CopilotChat').setup {
  -- See Configuration section for options
  model = 'claude-sonnet-4.6',
}
