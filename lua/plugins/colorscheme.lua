return {
  {
    'AstroNvim/astrotheme',
    lazy = false,
    priority = 1000,
    config = function()
      require('astrotheme').setup {
        palette = 'astrodark',
      }
      vim.cmd 'colorscheme astrotheme'
    end,
  },
}
