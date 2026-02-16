return {
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    build = function()
      if vim.fn.has 'win32' ~= 0 then
        return 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false'
      else
        return 'make'
      end
    end,
    opts = {
      -- Example: set your instructions file and provider here
      instructions_file = '.copilot-instructions.md',
      provider = 'copilot',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      'zbirenbaum/copilot.lua', -- Copilot provider support
      'hrsh7th/nvim-cmp', -- Completion
      'MeanderingProgrammer/render-markdown.nvim', -- Markdown rendering
      'stevearc/dressing.nvim', -- UI improvements (or use 'folke/snacks.nvim')
    },
  },
}
