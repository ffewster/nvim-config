vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.cmd 'RenderMarkdown preview'
  end,
  once = true,
})
