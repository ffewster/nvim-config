-- nvim-treesitter and mini.nvim are already installed by the core setup
vim.pack.add { { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim', version = '4663eb3ecd538bd5062628fb6d95bbe6bdca78f6' } }

---@module 'render-markdown'
---@type render.md.UserConfig
require('render-markdown').setup {
  file_types = { 'markdown' },
  render_modes = true,
  heading = {
    enabled = true,
    render_modes = false,
    atx = true,
    setext = true,
    sign = true,
    icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
    position = 'overlay',
    signs = { '󰫎 ' },
    width = 'full',
    left_margin = 0,
    left_pad = 0,
    right_pad = 0,
    min_width = 0,
    border = true,
    border_virtual = true,
    border_prefix = false,
    above = '▄',
    below = '▀',
    backgrounds = {
      'RenderMarkdownH1Bg',
      'RenderMarkdownH2Bg',
      'RenderMarkdownH3Bg',
      'RenderMarkdownH4Bg',
      'RenderMarkdownH5Bg',
      'RenderMarkdownH6Bg',
    },
    foregrounds = {
      'RenderMarkdownH1',
      'RenderMarkdownH2',
      'RenderMarkdownH3',
      'RenderMarkdownH4',
      'RenderMarkdownH5',
      'RenderMarkdownH6',
    },
    custom = {},
  },
}
