return {
  -- Dashboard
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'nvim-telescope/telescope.nvim',
    },
    keys = {
      { '<leader>gs', '<cmd>Neogit<CR>', desc = 'Git Status (Dashboard)' },
      { '<leader>gc', '<cmd>Neogit commit<CR>', desc = 'Git Commit' },
      { '<leader>gp', '<cmd>Neogit push<CR>', desc = 'Git Push' },
    },
    config = function()
      require('neogit').setup {
        disable_commit_confirmation = false,
        kind = 'tab', -- Open big views in a new tab
        integrations = {
          diffview = true,
        },
      }
    end,
  },

  -- The Conflict Solver
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose' },
    keys = {
      { '<leader>odv', '<cmd>DiffviewOpen<CR>', desc = 'Start Conflict Resolution' },
      { '<leader>cdv', '<cmd>DiffviewClose<CR>', desc = 'Quit Conflict Resolution' },
    },
    config = function()
      local actions = require 'diffview.actions' -- Import the actions module

      require('diffview').setup {
        view = {
          merge_tool = {
            layout = 'diff3_mixed',
            disable_diagnostics = true,
          },
        },
        keymaps = {
          view = {
            -- Navigation
            { 'n', '<leader>nc', actions.select_next_entry, { desc = 'Next Conflict' } },
            { 'n', '<leader>pc', actions.select_prev_entry, { desc = 'Prev Conflict' } },

            -- RESOLVE: Smart Actions (Fixes E94)
            -- Apply 'Ours' (Left side) to the conflict under cursor
            { 'n', '<leader>al', actions.conflict_choose 'ours', { desc = 'Merge: Choose Ours (Left)' } },

            -- Apply 'Theirs' (Right side) to the conflict under cursor
            { 'n', '<leader>ar', actions.conflict_choose 'theirs', { desc = 'Merge: Choose Theirs (Right)' } },

            -- Apply Both (Ours then Theirs)
            { 'n', '<leader>ab', actions.conflict_choose 'all', { desc = 'Merge: Choose Both' } },

            -- Apply None (Delete conflict block)
            { 'n', '<leader>an', actions.conflict_choose 'base', { desc = 'Merge: Choose Base (Delete)' } },
          },
        },
      }
    end,
  },

  -- The Editor Helper
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre', -- Load immediately when reading a file
    config = function()
      require('gitsigns').setup {
        current_line_blame = true, -- Ghost text showing who wrote the line
        current_line_blame_opts = { delay = 500 },

        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
          end

          -- Navigation
          map('n', ']h', gs.next_hunk, 'Next Git Change')
          map('n', '[h', gs.prev_hunk, 'Prev Git Change')

          -- Actions
          map('n', '<leader>hs', gs.stage_hunk, 'Stage Hunk')
          map('n', '<leader>hr', gs.reset_hunk, 'Reset Hunk (Undo)')
          map('n', '<leader>hp', gs.preview_hunk, 'Preview Hunk')
          map('n', '<leader>hb', function()
            gs.blame_line { full = true }
          end, 'Blame Line Full')
        end,
      }
    end,
  },
}
