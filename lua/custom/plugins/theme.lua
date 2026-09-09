-- require('nordic').load()
-- vim.cmd.colorscheme 'nordic'

-- installed via lua/custom/plugins/init.lua
require('gruvbox').setup {
  contrast = 'hard',
  transparent_mode = true,
  overrides = {
    NormalFloat = { bg = '#1d2021' },
    FloatBorder = { bg = '#1d2021' },
    TelescopeNormal = { bg = '#1d2021' },
    TelescopeBorder = { bg = '#1d2021' },
    TelescopePromptNormal = { bg = '#1d2021' },
    TelescopePromptBorder = { bg = '#1d2021' },
    TelescopeResultsNormal = { bg = '#1d2021' },
    TelescopeResultsBorder = { bg = '#1d2021' },
    TelescopePreviewNormal = { bg = '#1d2021' },
    TelescopePreviewBorder = { bg = '#1d2021' },
  },
}
vim.cmd.colorscheme 'gruvbox'
