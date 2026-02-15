return {
  -- Lualine: AstroNvim-style statusline (replaces mini.statusline)
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VeryLazy',
    opts = {
      options = {
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
        disabled_filetypes = { statusline = { 'alpha' } },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = {
          {
            function()
              local clients = vim.lsp.get_clients { bufnr = 0 }
              if #clients == 0 then
                return ''
              end
              local names = {}
              for _, client in ipairs(clients) do
                table.insert(names, client.name)
              end
              return ' ' .. table.concat(names, ', ')
            end,
          },
          'filetype',
        },
        lualine_y = { 'location' },
        lualine_z = { 'progress' },
      },
    },
  },

  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = 'VimEnter',
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'

      dashboard.section.header.val = {
        '   ███    ██ ██    ██ ██ ███    ███',
        '   ████   ██ ██    ██ ██ ████  ████',
        '   ██ ██  ██ ██    ██ ██ ██ ████ ██',
        '   ██  ██ ██  ██  ██  ██ ██  ██  ██',
        '   ██   ████   ████   ██ ██      ██',
      }

      dashboard.section.buttons.val = {
        dashboard.button('f', '  Find File', '<cmd>Telescope find_files<CR>'),
        dashboard.button('n', '  New File', '<cmd>ene <BAR> startinsert<CR>'),
        dashboard.button('g', '  Find Text', '<cmd>Telescope live_grep<CR>'),
        dashboard.button('r', '  Recent Files', '<cmd>Telescope oldfiles<CR>'),
        dashboard.button('c', '  Config', '<cmd>e $MYVIMRC<CR>'),
        dashboard.button('q', '  Quit', '<cmd>qa<CR>'),
      }

      dashboard.section.header.opts.hl = 'AlphaHeader'
      dashboard.section.buttons.opts.hl = 'AlphaButtons'
      dashboard.section.footer.opts.hl = 'AlphaFooter'

      dashboard.opts.layout[1].val = 8

      alpha.setup(dashboard.opts)

      -- Show lazy stats in footer after loading
      vim.api.nvim_create_autocmd('User', {
        pattern = 'LazyVimStarted',
        callback = function()
          local stats = require('lazy').stats()
          dashboard.section.footer.val = '⚡ Neovim loaded '
            .. stats.loaded
            .. '/'
            .. stats.count
            .. ' plugins in '
            .. string.format('%.2f', stats.startuptime)
            .. 'ms'
          pcall(vim.cmd, 'AlphaRedraw')
        end,
      })
    end,
  },

  -- Which-key
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = vim.g.have_nerd_font,
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      spec = {
        { '<leader>f', group = '[F]uzzy Finder' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- AstroUI
  {
    'AstroNvim/astroui',
    config = function()
      require('astroui').setup {
        icons = {},
      }
    end,
  },

  -- Web devicons (shared dependency)
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  -- GitHub theme (kept from original config)
  { 'projekt0n/github-nvim-theme', name = 'github-theme' },
}
