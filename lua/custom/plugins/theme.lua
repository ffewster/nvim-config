-- installed via lua/custom/plugins/init.lua
local variable = '#e07a78'

require('koda').setup {
  colors = { keyword = '#f5c542', func = '#7fbfe0' },
  -- koda has no palette key for variables
  on_highlights = function(hl)
    for _, g in ipairs { '@variable', '@variable.parameter', '@variable.member' } do
      hl[g] = { fg = variable }
    end
  end,
}
vim.cmd.colorscheme 'koda-dark'
