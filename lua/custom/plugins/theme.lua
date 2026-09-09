-- vim.pack.add { 'https://github.com/AlexvZyl/nordic.nvim' }
-- require('nordic').load()
-- vim.cmd.colorscheme 'nordic'

vim.pack.add { { src = 'https://github.com/ellisonleao/gruvbox.nvim', version = '154eb5ff5b96d0641307113fa385eaf0d36d9796' } }
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
