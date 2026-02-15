return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      icons = {
        button = '󰅖',
        modified = { button = '●' },
        -- Minimal separators like AstroNvim
        separator = { left = ' ', right = ' ' },
        inactive = { separator = { left = ' ', right = ' ' } },
        pinned = { button = '', filename = true },
      },
      minimum_padding = 2,
      maximum_padding = 2,
    },
  },
}
