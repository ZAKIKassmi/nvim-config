return {

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
