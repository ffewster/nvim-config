if vim.fn.executable 'tree-sitter' == 0 then
  vim.schedule(function() vim.notify('tree-sitter-cli not found! Run: npm install -g tree-sitter-cli', vim.log.levels.WARN) end)
end

vim.filetype.add {
  pattern = {
    ['.*/templates/.*%.yaml'] = 'helm',
    ['.*/templates/.*%.tpl'] = 'helm',
    ['helmfile.*%.yaml'] = 'helm',
  },
}

-- Kotlin debugging support, layered onto kickstart's nvim-dap setup
-- (lua/kickstart/plugins/debug.lua) without editing that file. Hooks
-- Lazy's `User LazyLoad` event so this runs once nvim-dap actually loads.
vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyLoad',
  callback = function(ev)
    if ev.data ~= 'nvim-dap' then
      return
    end

    local ok, registry = pcall(require, 'mason-registry')
    if ok then
      pcall(function()
        if not registry.is_installed 'kotlin-debug-adapter' then
          registry.get_package('kotlin-debug-adapter'):install()
        end
      end)
    end

    local dap = require 'dap'
    dap.adapters.kotlin = {
      type = 'executable',
      command = 'kotlin-debug-adapter',
    }
    dap.configurations.kotlin = {
      {
        type = 'kotlin',
        request = 'attach',
        name = 'Attach to Kotlin Process',
        projectRoot = vim.fn.getcwd,
        hostName = 'localhost',
        port = 5005,
      },
    }
  end,
})
