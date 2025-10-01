return {
  -- Colorscheme collection
  { 'folke/tokyonight.nvim', priority = 1000 },
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  { 'rebelot/kanagawa.nvim', priority = 1000 },
  { 'rose-pine/neovim', name = 'rose-pine', priority = 1000 },
  { 'ellisonleao/gruvbox.nvim', priority = 1000 },
  { 'navarasu/onedark.nvim', priority = 1000 },
  { 'EdenEast/nightfox.nvim', priority = 1000 },
  { 'sainnhe/everforest', priority = 1000 },
  { 'Mofiqul/dracula.nvim', priority = 1000 },

  -- Theme picker keybinding and config
  {
    'nvim-telescope/telescope.nvim',
    keys = {
      {
        '<leader>th',
        function()
          local pickers = require 'telescope.pickers'
          local finders = require 'telescope.finders'
          local conf = require('telescope.config').values
          local actions = require 'telescope.actions'
          local action_state = require 'telescope.actions.state'

          local themes = {
            { 'tokyonight-night', 'Tokyo Night (Night)' },
            { 'tokyonight-storm', 'Tokyo Night (Storm)' },
            { 'tokyonight-day', 'Tokyo Night (Day)' },
            { 'tokyonight-moon', 'Tokyo Night (Moon)' },
            { 'catppuccin-mocha', 'Catppuccin (Mocha)' },
            { 'catppuccin-macchiato', 'Catppuccin (Macchiato)' },
            { 'catppuccin-frappe', 'Catppuccin (Frappe)' },
            { 'catppuccin-latte', 'Catppuccin (Latte)' },
            { 'kanagawa', 'Kanagawa' },
            { 'kanagawa-wave', 'Kanagawa (Wave)' },
            { 'kanagawa-dragon', 'Kanagawa (Dragon)' },
            { 'kanagawa-lotus', 'Kanagawa (Lotus)' },
            { 'rose-pine', 'Rose Pine' },
            { 'rose-pine-moon', 'Rose Pine (Moon)' },
            { 'rose-pine-dawn', 'Rose Pine (Dawn)' },
            { 'gruvbox', 'Gruvbox' },
            { 'onedark', 'One Dark' },
            { 'nightfox', 'Night Fox' },
            { 'dayfox', 'Day Fox' },
            { 'dawnfox', 'Dawn Fox' },
            { 'duskfox', 'Dusk Fox' },
            { 'nordfox', 'Nord Fox' },
            { 'terafox', 'Tera Fox' },
            { 'carbonfox', 'Carbon Fox' },
            { 'github_dark', 'GitHub Dark' },
            { 'github_dark_dimmed', 'GitHub Dark Dimmed' },
            { 'github_light', 'GitHub Light' },
            { 'everforest', 'Everforest' },
            { 'dracula', 'Dracula' },
          }

          local current = vim.g.colors_name or 'default'

          pickers
            .new({}, {
              prompt_title = 'Choose Theme',
              finder = finders.new_table {
                results = themes,
                entry_maker = function(entry)
                  local display = entry[2]
                  if entry[1] == current then
                    display = display .. ' ✓'
                  end
                  return {
                    value = entry[1],
                    display = display,
                    ordinal = entry[2],
                  }
                end,
              },
              sorter = conf.generic_sorter {},
              attach_mappings = function(bufnr)
                actions.select_default:replace(function()
                  local selection = action_state.get_selected_entry()
                  actions.close(bufnr)
                  if selection then
                    pcall(vim.cmd, 'colorscheme ' .. selection.value)
                    vim.notify('Theme: ' .. selection.display, vim.log.levels.INFO)

                    local file = io.open(vim.fn.stdpath 'data' .. '/theme.txt', 'w')
                    if file then
                      file:write(selection.value)
                      file:close()
                    end
                  end
                end)
                return true
              end,
            })
            :find()
        end,
        desc = '[T]oggle t[H]eme picker',
      },
    },
    opts = function(_, opts)
      -- Load saved theme on startup
      vim.defer_fn(function()
        local file = io.open(vim.fn.stdpath 'data' .. '/theme.txt', 'r')
        if file then
          local theme = file:read '*l'
          file:close()
          if theme then
            pcall(vim.cmd, 'colorscheme ' .. theme)
          end
        else
          pcall(vim.cmd, 'colorscheme tokyonight-night')
        end
      end, 0)
      return opts
    end,
  },
}
