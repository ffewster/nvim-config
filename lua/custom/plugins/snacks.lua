-- installed via lua/custom/plugins/init.lua
---@type snacks.Config
require('snacks').setup {
  bigfile = { enabled = true },
  dashboard = {
    enabled = true,
    preset = {
      header = table.concat({
        '█   █  █   █  █████  █   █',
        '██  █  █   █    █    ██ ██',
        '█ █ █  █   █    █    █ █ █',
        '█  ██   █ █     █    █   █',
        '█   █    █    █████  █   █',
      }, '\n'),
    },
    sections = {
      { section = 'header', padding = 1 },
      { section = 'keys', gap = 1, padding = 1 },
      {
        pane = 2,
        icon = ' ',
        desc = 'Browse Repo',
        padding = 1,
        key = 'b',
        action = function()
          Snacks.gitbrowse()
        end,
      },
      { pane = 2, section = 'recent_files', title = 'Recent Files', cwd = true, limit = 5, indent = 2, padding = 1 },
      { pane = 2, section = 'projects', title = 'Projects', limit = 5, indent = 2, padding = 1 },
      function()
        local in_git = Snacks.git.get_root() ~= nil
        local has_remote = in_git and vim.fn.system 'git remote' ~= ''
        local cmds = {
          {
            icon = ' ',
            title = 'Git Status',
            cmd = 'git --no-optional-locks status --short --branch',
            height = 10,
            enabled = in_git,
          },
        }
        return vim.tbl_map(function(cmd)
          return vim.tbl_extend('force', {
            pane = 2,
            section = 'terminal',
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          }, cmd)
        end, cmds)
      end,
      -- ponytail: dropped { section = 'startup' } — it hard-requires 'lazy.stats',
      -- which no longer exists now that we're on vim.pack instead of lazy.nvim
    },
  },
  explorer = { enabled = false },
  indent = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true },
  notifier = {
    enabled = true,
    -- snacks replaces vim.notify, so nothing reaches :messages; mirror it there.
    -- filter runs once per notification; always returns true so nothing is hidden.
    filter = function(notif)
      vim.api.nvim_echo({ { notif.msg } }, true, {})
      return true
    end,
  },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
}
