-- installed via lua/custom/plugins/init.lua
local variable = '#e07a78'
local yellow = '#f5c542'

require('koda').setup {
  transparent = true,
  colors = { keyword = yellow, func = '#7fbfe0' },
  -- koda has no palette key for variables
  on_highlights = function(hl)
    hl.Cursor = { bg = yellow, fg = '#000000' }
    for _, g in ipairs { '@variable', '@variable.parameter', '@variable.member' } do
      hl[g] = { fg = variable }
    end
  end,
}
-- default guicursor has no highlight group, so Cursor would be ignored
vim.o.guicursor = 'n-v-c-sm:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor'
vim.cmd.colorscheme 'koda-dark'
