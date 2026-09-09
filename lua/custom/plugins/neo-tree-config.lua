-- installed via lua/custom/plugins/init.lua
-- (nvim-tree/nvim-web-devicons dependency is covered by mini.icons' devicons compat shim)
local toggle_tree = function()
  vim.cmd 'Neotree toggle'
  vim.opt.relativenumber = true -- Use relative line numbers
end

vim.keymap.set('n', '<leader>e', toggle_tree, { desc = 'Open NeoTree' })
vim.keymap.set('n', '<leader>n', function() vim.cmd 'Neotree focus' end, { desc = 'Focus NeoTree' })
vim.keymap.set('n', '\\', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })

require('neo-tree').setup {
  default_component_configs = {
    indent = {
      with_expanders = true,
    },
  },
  filesystem = {
    window = {
      position = 'default',
      mappings = {
        ['\\'] = 'close_window',
      },
    },
    follow_current_file = {
      enabled = true,
    },
    group_empty_dirs = true,
  },
  source_selector = {
    winbar = true,
    statusline = false,
  },
}
