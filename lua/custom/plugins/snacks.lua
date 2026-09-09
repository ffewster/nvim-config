vim.pack.add { { src = 'https://github.com/folke/snacks.nvim', version = '882c996cf28183f4d63640de0b4c02ec886d01f2' } }

---@type snacks.Config
require('snacks').setup {
  bigfile = { enabled = true },
  dashboard = {
    enabled = true,
    preset = {},
    sections = {
      { section = 'header' },
      {
        pane = 1,
        section = 'terminal',
        cmd = 'command -v fortune >/dev/null && command -v cowsay >/dev/null && fortune | cowsay || echo Moo',
        height = 10,
        padding = 1,
      },
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
      function()
        local in_git = Snacks.git.get_root() ~= nil
        local has_remote = in_git and vim.fn.system 'git remote' ~= ''
        local cmds = {
          {
            icon = ' ',
            title = 'Git Status',
            cmd = 'git --no-pager diff --stat -B -M -C || echo "Nothing to report"',
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
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
}
