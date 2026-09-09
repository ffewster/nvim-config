vim.pack.add { { src = 'https://github.com/zbirenbaum/copilot.lua', version = '901a6c564abb45c7703401ecc6416bb0d15afd37' } }
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
