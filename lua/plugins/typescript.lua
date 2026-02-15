return {
  {
    'yioneko/nvim-vtsls',
    ft = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      local lspconfig = require 'lspconfig'
      local lspconfig_util = require 'lspconfig.util'

      require('lspconfig.configs').vtsls = require('vtsls').lspconfig

      local function filter_diagnostics(err, result, ctx, config)
        if result.diagnostics then
          local ignored_codes = { [6133] = true, [6192] = true, [6196] = true, [6198] = true }
          local new_diagnostics = {}
          for _, diagnostic in ipairs(result.diagnostics) do
            if not ignored_codes[diagnostic.code] then
              table.insert(new_diagnostics, diagnostic)
            end
          end
          result.diagnostics = new_diagnostics
        end
        vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
      end

      lspconfig.vtsls.setup {
        root_dir = lspconfig_util.root_pattern('.git', 'tsconfig.json'),
        handlers = {
          ['textDocument/publishDiagnostics'] = filter_diagnostics,
        },
        settings = {
          vtsls = {
            enableMoveToFileCodeAction = true,
            autoUseWorkspaceTsdk = true,
            experimental = { completion = { enableServerSideFuzzyMatch = true } },
          },
          typescript = {
            updateImportsOnFileMove = { enabled = 'always' },
          },
        },
        on_attach = function(client, bufnr)
          local map = vim.keymap.set
          local opts = { buffer = bufnr, silent = true }

          map('n', '<leader>oi', '<cmd>VtsExec organize_imports<CR>', opts)
          map('n', '<leader>os', '<cmd>VtsExec sort_imports<CR>', opts)
          map('n', '<leader>ru', '<cmd>VtsExec remove_unused<CR>', opts)
          map('n', '<leader>ri', '<cmd>VtsExec remove_unused_imports<CR>', opts)
          map('n', '<leader>am', '<cmd>VtsExec add_missing_imports<CR>', opts)
          map('n', '<leader>fa', '<cmd>VtsExec fix_all<CR>', opts)
          map('n', '<leader>gtsd', '<cmd>VtsExec go_to_source_definition<CR>', opts)

          map('n', '<leader>rn', vim.lsp.buf.rename, opts)
          map('n', 'gr', vim.lsp.buf.references, opts)
        end,
      }
    end,
  },
}
