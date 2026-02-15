return {
  -- Smart splits
  {
    'mrjones2014/smart-splits.nvim',
    lazy = false,
    config = function()
      local smart_splits = require 'smart-splits'

      local function only_if_split(fn)
        return function()
          if vim.fn.winnr '$' > 1 then
            fn()
          end
        end
      end

      -- Resize (Alt + hjkl)
      vim.keymap.set('n', '<A-h>', only_if_split(smart_splits.resize_left))
      vim.keymap.set('n', '<A-j>', only_if_split(smart_splits.resize_down))
      vim.keymap.set('n', '<A-k>', only_if_split(smart_splits.resize_up))
      vim.keymap.set('n', '<A-l>', only_if_split(smart_splits.resize_right))

      -- Navigate (Ctrl + hjkl)
      vim.keymap.set('n', '<C-h>', only_if_split(smart_splits.move_cursor_left))
      vim.keymap.set('n', '<C-j>', only_if_split(smart_splits.move_cursor_down))
      vim.keymap.set('n', '<C-k>', only_if_split(smart_splits.move_cursor_up))
      vim.keymap.set('n', '<C-l>', only_if_split(smart_splits.move_cursor_right))

      -- Swap Buffers (Leader + w + direction)
      vim.keymap.set('n', '<leader>wh', only_if_split(smart_splits.swap_buf_left))
      vim.keymap.set('n', '<leader>wj', only_if_split(smart_splits.swap_buf_down))
      vim.keymap.set('n', '<leader>wk', only_if_split(smart_splits.swap_buf_up))
      vim.keymap.set('n', '<leader>wl', only_if_split(smart_splits.swap_buf_right))
    end,
  },

  -- Aerial (symbol outline)
  {
    'stevearc/aerial.nvim',
    event = 'VeryLazy',
    opts = {
      backends = { 'lsp', 'treesitter', 'markdown', 'man' },
      layout = {
        resize_to_content = false,
        default_direction = 'left',
        max_width = { 40, 0.2 },
        min_width = 20,
        preserve_equality = true,
      },
      nerd_font = true,
      show_guides = true,
      filter_kind = {
        'Class',
        'Constructor',
        'Enum',
        'Function',
        'Interface',
        'Module',
        'Method',
        'Struct',
        'Variable',
      },
      keymaps = {
        ['?'] = 'actions.show_help',
        ['<CR>'] = 'actions.jump',
        ['<2-LeftMouse>'] = 'actions.jump',
        ['<C-v>'] = 'actions.jump_vsplit',
        ['<C-s>'] = 'actions.jump_split',
        ['p'] = 'actions.scroll',
      },
      close_on_select = false,
    },
    keys = {
      { '<leader>at', '<cmd>AerialToggle<cr>', desc = 'Toggle Aerial (Symbols)' },
    },
  },

  -- Trouble
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      {
        '<leader>aa',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>an',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>tl',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>ql',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
}
