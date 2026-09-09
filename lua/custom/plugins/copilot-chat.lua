-- installed via lua/custom/plugins/init.lua
vim.keymap.set('n', '<leader>ch', '<Cmd>CopilotChatToggle<CR>', { noremap = true, silent = true })

require('CopilotChat').setup {
  -- See Configuration section for options
  model = 'claude-sonnet-4.6',
}
