-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Every custom plugin's vim.pack.add() call lives here, pinned to an exact
-- commit, so nothing in this directory drifts on a plain `vim.pack.update()`.
-- This has to happen before the auto-discovery loop below, since that loop's
-- file order is unspecified - a plugin file's require()/setup() call would be
-- able to run before its own vim.pack.add() otherwise. Individual plugin
-- files below just do require(...).setup{} and keymaps.
--
-- barbar.nvim reads this global as soon as it's added below, so it has to be
-- set here rather than in tabs.lua (which now runs after this point).
vim.g.barbar_auto_setup = false

vim.pack.add {
  { src = 'https://github.com/coder/claudecode.nvim', version = '2390c6e45c4789072c293ac69de051d169668b29' },
  { src = 'https://github.com/numToStr/Comment.nvim', version = 'e30b7f2008e52442154b66f7c519bfd2f1e32acb' },
  { src = 'https://github.com/CopilotC-Nvim/CopilotChat.nvim', version = '004ced055d8db59561cfcddc5f141ccd8d5a033b' },
  { src = 'https://github.com/zbirenbaum/copilot.lua', version = '901a6c564abb45c7703401ecc6416bb0d15afd37' },
  { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim', version = '4663eb3ecd538bd5062628fb6d95bbe6bdca78f6' },
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = 'f3f3bf73414e400cf9fc13fda50f00404a8f8ab1' },
  { src = 'https://github.com/MunifTanjim/nui.nvim', version = '10fc361835c856ba4233ef5ea135b919bf3dce97' },
  { src = 'https://github.com/tpope/vim-sleuth', version = 'be69bff86754b1aa5adcbb527d7fcd1635a84080' },
  { src = 'https://github.com/folke/snacks.nvim', version = '882c996cf28183f4d63640de0b4c02ec886d01f2' },
  { src = 'https://github.com/romgrk/barbar.nvim', version = '53b5a2f34b68875898f0531032fbf090e3952ad7' },
  { src = 'https://github.com/ellisonleao/gruvbox.nvim', version = '154eb5ff5b96d0641307113fa385eaf0d36d9796' },
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
