return {
  {
    'Wansmer/symbol-usage.nvim',
    event = 'LspAttach',
    config = function()
      require('symbol-usage').setup {
        references = { enabled = true, include_declaration = false },
        definition = { enabled = false },
        implementation = { enabled = false },
        text_format = function(symbol)
          if symbol.references then
            return '󰌹 ' .. symbol.references
          end
          return ''
        end,
      }
    end,
  },
}
