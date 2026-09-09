-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Every custom plugin's vim.pack.add() call lives here, same as core kickstart
-- plugins: bare src, no version pin, tracked via nvim-pack-lock.json like
-- everything else. `version` is only set below where a plugin's default
-- branch isn't the one we actually want (e.g. neo-tree.nvim defaults to
-- `main`, but the stable line is the separate `v3.x` branch) - that's a
-- branch selection, not a freeze, same as nvim-treesitter's `version = 'main'`
-- in init.lua.
--
-- This has to happen before the auto-discovery loop below, since that loop's
-- file order is unspecified - a plugin file's require()/setup() call would be
-- able to run before its own vim.pack.add() otherwise. Individual plugin
-- files below just do require(...).setup{} and keymaps.
--
-- barbar.nvim reads this global as soon as it's added below, so it has to be
-- set here rather than in tabs.lua (which now runs after this point).
vim.g.barbar_auto_setup = false

vim.pack.add {
  'https://github.com/coder/claudecode.nvim',
  'https://github.com/numToStr/Comment.nvim',
  'https://github.com/CopilotC-Nvim/CopilotChat.nvim',
  'https://github.com/zbirenbaum/copilot.lua',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = 'v3.x' },
  'https://github.com/MunifTanjim/nui.nvim',
  'https://github.com/tpope/vim-sleuth',
  'https://github.com/folke/snacks.nvim',
  'https://github.com/romgrk/barbar.nvim',
  'https://github.com/ellisonleao/gruvbox.nvim',
}

-- Iterate over all Lua files in the plugins directory and load them.
-- `vim.fs.dir()` iteration order is unspecified and must not be relied upon.
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'plugins')
for file_name, type in vim.fs.dir(plugins_dir, { follow = true }) do
  if (type == 'file' or type == 'link') and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    local module = file_name:gsub('%.lua$', '')
    require('custom.plugins.' .. module)
  end
end
