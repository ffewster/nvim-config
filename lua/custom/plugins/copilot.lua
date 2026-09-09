vim.pack.add { 'https://github.com/zbirenbaum/copilot.lua' }
require('copilot').setup {
  suggestion = {
    enabled = true,
    auto_trigger = true,
    keymap = {
      accept = '<M-l>',
    },
  },
  panel = {
    enabled = true,
    auto_refresh = true,
  },
  filetypes = {
    ['*'] = true,
    typescript = true,
  },
}
