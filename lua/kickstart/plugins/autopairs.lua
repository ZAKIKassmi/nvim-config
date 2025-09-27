-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local npairs = require 'nvim-autopairs'
    npairs.setup {
      check_ts = true, -- enable treesitter checks
      ts_config = {
        javascript = { 'string', 'template_string' },
        typescript = { 'string', 'template_string' },
      },
    }
  end,
}
