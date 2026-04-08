---@class snacks.dashboard.Config
---@field enabled? boolean
---@field sections snacks.dashboard.Section
---@field formats table<string, snacks.dashboard.Text|fun(item:snacks.dashboard.Item, ctx:snacks.dashboard.Format.ctx):snacks.dashboard.Text>
local dashboard_config = {
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
      icon = ' ',
      desc = 'Browse Repo',
      padding = 1,
      key = 'b',
      action = function() Snacks.gitbrowse() end,
    },
    function()
      local in_git = Snacks.git.get_root() ~= nil
      local has_remote = in_git and vim.fn.system 'git remote' ~= ''
      local cmds = {
        {
          icon = ' ',
          title = 'Open PRs',
          cmd = 'gh pr list -L 3',
          key = 'P',
          action = function() vim.fn.jobstart('gh pr list --web', { detach = true }) end,
          height = 7,
          enabled = has_remote,
        },
        {
          icon = ' ',
          title = 'Git Status',
          cmd = 'git --no-pager diff --stat -B -M -C || echo "Nothing to report"',
          height = 10,
          enabled = in_git,
        },
      }
      return vim.tbl_map(
        function(cmd)
          return vim.tbl_extend('force', {
            pane = 2,
            section = 'terminal',
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          }, cmd)
        end,
        cmds
      )
    end,
    { section = 'startup' },
  },
}

return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = dashboard_config,
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
}
