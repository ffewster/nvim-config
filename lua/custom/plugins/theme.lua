-- installed via lua/custom/plugins/init.lua
local variable = '#e07a78'
local yellow ='#f5c542'
local blue = '#7fbfe0'
local orange = '#e8a05a'
local white = '#ffffff'
local fg = '#d0d0d0'

require('koda').setup {
  transparent = true,
  colors = {
    fg = fg,
    type = fg,
    operator = fg,
    emphasis = fg,
    special = fg,
    char = fg,
    border = '#555555',
    keyword = yellow,
    func = blue,
    string = orange,
    const = white,
  },
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
