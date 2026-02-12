--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Indentation: global defaults
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 15

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Disable netrw to prevent conflicts
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
-- See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- Standard Neovim Split Keymaps
vim.keymap.set('n', '<leader>|', '<cmd>vsplit<CR>', { desc = 'Vertical Split' })
vim.keymap.set('n', '<leader>-', '<cmd>split<CR>', { desc = 'Horizontal Split' })
vim.keymap.set('n', '<leader>cs', '<cmd>close<CR>', { desc = 'Close Split' })

-- barbar (tabs manager) keymaps
-- Buffer/Tab Navigation
vim.keymap.set('n', '<Tab>', '<Cmd>BufferNext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', { desc = 'Previous buffer' })

-- Jump to specific buffer by position
vim.keymap.set('n', '<leader>1', '<Cmd>BufferGoto 1<CR>', { desc = 'Go to buffer 1' })
vim.keymap.set('n', '<leader>2', '<Cmd>BufferGoto 2<CR>', { desc = 'Go to buffer 2' })
vim.keymap.set('n', '<leader>3', '<Cmd>BufferGoto 3<CR>', { desc = 'Go to buffer 3' })
vim.keymap.set('n', '<leader>4', '<Cmd>BufferGoto 4<CR>', { desc = 'Go to buffer 4' })
vim.keymap.set('n', '<leader>5', '<Cmd>BufferGoto 5<CR>', { desc = 'Go to buffer 5' })
vim.keymap.set('n', '<leader>6', '<Cmd>BufferGoto 6<CR>', { desc = 'Go to buffer 6' })
vim.keymap.set('n', '<leader>7', '<Cmd>BufferGoto 7<CR>', { desc = 'Go to buffer 7' })
vim.keymap.set('n', '<leader>8', '<Cmd>BufferGoto 8<CR>', { desc = 'Go to buffer 8' })
vim.keymap.set('n', '<leader>9', '<Cmd>BufferGoto 9<CR>', { desc = 'Go to buffer 9' })
vim.keymap.set('n', '<leader>0', '<Cmd>BufferLast<CR>', { desc = 'Go to last buffer' })

-- Close/Delete buffers
vim.keymap.set('n', '<leader>x', '<Cmd>BufferClose<CR>', { desc = 'Close current buffer' })
vim.keymap.set('n', '<leader>X', '<Cmd>BufferClose!<CR>', { desc = 'Force close buffer' })
vim.keymap.set('n', '<leader>bo', '<Cmd>BufferCloseAllButCurrent<CR>', { desc = 'Close all [B]uffers except current' })
vim.keymap.set('n', '<leader>bh', '<Cmd>BufferCloseBuffersLeft<CR>', { desc = 'Close all buffers to left' })
vim.keymap.set('n', '<leader>bl', '<Cmd>BufferCloseBuffersRight<CR>', { desc = 'Close all buffers to right' })

-- Reorder buffers
vim.keymap.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', { desc = 'Move buffer left' })
vim.keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>', { desc = 'Move buffer right' })

-- Pin/Unpin buffer (keeps it at the start of the tabline)
vim.keymap.set('n', '<leader>bp', '<Cmd>BufferPin<CR>', { desc = 'Toggle [B]uffer [P]in' })

-- Pick a buffer using hints
vim.keymap.set('n', '<leader>bb', '<Cmd>BufferPick<CR>', { desc = 'Pick [B]uffer' })

-- Sort buffers
vim.keymap.set('n', '<leader>bd', '<Cmd>BufferOrderByDirectory<CR>', { desc = 'Sort by [D]irectory' })
vim.keymap.set('n', '<leader>bn', '<Cmd>BufferOrderByBufferNumber<CR>', { desc = 'Sort by buffer [N]umber' })
vim.keymap.set('n', '<leader>be', '<Cmd>BufferOrderByExtension<CR>', { desc = 'Sort by [E]xtension' })
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

--  To update plugins you can run
require('lazy').setup({
  'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
  --

  -- Alternatively, use `config = function() ... end` for full control over the configuration.
  -- If you prefer to call `setup` explicitly, use:
  --    {
  --        'lewis6991/gitsigns.nvim',
  --        config = function()
  --            require('gitsigns').setup({
  --                -- Your gitsigns configuration here
  --            })
  --        end,
  --    }
  --
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`.
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
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

      -- Document existing key chains
      spec = {
        { '<leader>f', group = '[F]uzzy Finder' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>f/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      -- TODO: Add the ability to change theme
    end,
  },

  -- LSP Plugins
  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',

      -- YAML Intelligence
      'b0o/SchemaStore.nvim',
      'someone-stole-my-name/yaml-companion.nvim',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          local nice = 'hello'
          print(nice)

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

          -- Find references for the word under your cursor.
          map('<leader>rr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('<leader>gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('<leader>gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gb', '<C-o>', '[G]o [B]ack')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('<leader>gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('gt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        clangd = {},
        -- gopls = {},
        -- pyright = {},
        rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --
        dockerls = {},
        eslint = {},
        cssls = {},
        jsonls = {},
        tailwindcss = {},
        prettierd = {},
        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'dockerls', -- Language Server (Auto-complete, basic checks)
        'hadolint', -- Linter (Best-in-class Dockerfile best practices)
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>fo',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = 'fallback',
          }
        end
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        css = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'prettierd', 'prettier', stop_after_first = true },

        yaml = { 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },

  { -- Autocompletion
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '1.*',
    dependencies = {
      -- Snippet Engine
      {
        'L3MON4D3/LuaSnip',
        version = '2.*',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
        opts = {},
      },
      'folke/lazydev.nvim',
    },
    --- @module 'blink.cmp'
    --- @type blink.cmp.Config
    opts = {
      keymap = {
        -- 'default' (recommended) for mappings similar to built-in completions
        --   <c-y> to accept ([y]es) the completion.
        --    This will auto-import if your LSP supports it.
        --    This will expand snippets if the LSP sent a snippet.
        -- 'super-tab' for tab to accept
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- For an understanding of why the 'default' preset is recommended,
        -- you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        --
        -- All presets have the following mappings:
        -- <tab>/<s-tab>: move to right/left of your snippet expansion
        -- <c-space>: Open menu or open docs if already open
        -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
        -- <c-e>: Hide menu
        -- <c-k>: Toggle signature help
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        preset = 'enter',

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },

      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'normal',
      },

      completion = {
        -- By default, you may press `<c-space>` to show the documentation.
        menu = {
          border = 'rounded',
          -- This controls the column layout (Icon | Text | Description)
          draw = {
            columns = { { 'kind_icon', 'label', 'label_description', gap = 1 }, { 'kind' } },
          },
        },

        -- 2. ADD BORDERS to the documentation window
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          window = { border = 'rounded' },
        },
      },

      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev' },
        providers = {
          lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        },
      },

      snippets = { preset = 'luasnip' },

      -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
      -- which automatically downloads a prebuilt binary when enabled.
      --
      -- By default, we use the Lua implementation instead, but you may enable
      -- the rust implementation via `'prefer_rust_with_warning'`
      --
      -- See :h blink-cmp-config-fuzzy for more information
      fuzzy = { implementation = 'lua' },

      -- Shows a signature help window while you type arguments for a function
      signature = { enabled = true },
    },
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('tokyonight').setup {
        -- [NEW] Enable transparency
        transparent = true,

        styles = {
          comments = { italic = false }, -- Disable italics in comments
          -- [NEW] Make these transparent too so they don't look like solid blocks
          sidebars = 'transparent',
          floats = 'transparent',
        },
      }

      -- Load the colorscheme here.
      vim.cmd.colorscheme 'tokyonight-night'
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = vim.g.have_nerd_font }

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    branch = 'master', -- <-- THE MODIFICATION
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs', -- Sets main module to use for opts
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`
    opts = {
      ensure_installed = {
        'bash',
        'c',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'query',
        'vim',
        'vimdoc',
        'javascript',
        'typescript',
        'tsx',
        'css',
        'json',
        'java',
        'dockerfile',
      },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
    -- There are additional nvim-treesitter modules that you can use to interact
    -- with nvim-treesitter. You should go explore a few and see what interests you:
    --
    --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
    --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
    --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  },
  -- auto-closing tags
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    -- Keys section for lazy-loading
    keys = {
      {
        '-',
        function()
          require('neo-tree.command').execute { toggle = true, dir = vim.uv.cwd() }
        end,
        desc = 'Toggle Neo-tree',
      },
    },
    -- Configuration options
    opts = {
      -- VS Code Behavior: Close if it's the last window
      close_if_last_window = true,

      -- VS Code Behavior: Git status colors
      enable_git_status = true,
      enable_diagnostics = true,

      -- VS Code Behavior: Filesystem settings
      filesystem = {
        follow_current_file = {
          enabled = true, -- Focus the file you are editing in the tree
          leave_dirs_open = true, -- Close folders that aren't active
        },
        use_libuv_file_watcher = true, -- Auto-update when files change externally
        filtered_items = {
          visible = false, -- hide hidden files by default
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },

      -- Visual settings to look like VS Code
      default_component_configs = {
        indent = {
          with_expanders = true, -- Use arrows instead of indentation lines
          expander_collapsed = '',
          expander_expanded = '',
        },
        git_status = {
          symbols = {
            added = '✚',
            modified = '',
            deleted = '✖',
            renamed = '󰁕',
            untracked = '',
            ignored = '',
            unstaged = '󰄱',
            staged = '',
            conflict = '',
          },
        },
      },

      -- Window settings
      window = {
        position = 'right', -- Your requested position
        width = 30,
        mappings = {
          ['<2-LeftMouse>'] = 'open',
          ['<cr>'] = 'open',
          ['l'] = 'open',
        },
      },
    },
  },

  -- Oil file explorer
  -- {
  --   'stevearc/oil.nvim',
  --   ---@module 'oil'
  --   ---@type oil.SetupOpts
  --   opts = {},
  --   -- Use web_dev_icons
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  --   config = function()
  --     require('oil').setup {
  --       columns = { 'icon' },
  --       keymaps = {
  --         ['.'] = 'actions.toggle_hidden',
  --       },
  --     }
  --
  --     vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  --   end,
  --
  --   -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  --   lazy = false,
  -- },

  -- screen splite
  -- {
  --   'mrjones2014/smart-splits.nvim',
  --   lazy = false, -- mappings need to exist immediately
  --   config = function()
  --     local smart_splits = require 'smart-splits'
  --
  --     -- helper: only run if more than 1 window exists
  --     local function only_if_split(fn)
  --       return function()
  --         if vim.fn.winnr '$' > 1 then
  --           fn()
  --         end
  --       end
  --     end
  --
  --     -- Resize (Alt + hjkl)
  --     vim.keymap.set('n', '<A-h>', only_if_split(smart_splits.resize_left))
  --     vim.keymap.set('n', '<A-j>', only_if_split(smart_splits.resize_down))
  --     vim.keymap.set('n', '<A-k>', only_if_split(smart_splits.resize_up))
  --     vim.keymap.set('n', '<A-l>', only_if_split(smart_splits.resize_right))
  --
  --     -- Navigate (Ctrl + hjkl)
  --     vim.keymap.set('n', '<C-h>', only_if_split(smart_splits.move_cursor_left))
  --     vim.keymap.set('n', '<C-j>', only_if_split(smart_splits.move_cursor_down))
  --     vim.keymap.set('n', '<C-k>', only_if_split(smart_splits.move_cursor_up))
  --     vim.keymap.set('n', '<C-l>', only_if_split(smart_splits.move_cursor_right))
  --
  --     -- Swap Buffers (Leader + w + direction)
  --     vim.keymap.set('n', '<leader>wh', only_if_split(smart_splits.swap_buf_left))
  --     vim.keymap.set('n', '<leader>wj', only_if_split(smart_splits.swap_buf_down))
  --     vim.keymap.set('n', '<leader>wk', only_if_split(smart_splits.swap_buf_up))
  --     vim.keymap.set('n', '<leader>wl', only_if_split(smart_splits.swap_buf_right))
  --   end,
  -- },
  -- focus on the current chosen screen
  {
    'nvim-focus/focus.nvim',
    event = 'WinEnter',
    config = function()
      require('focus').setup {
        -- Width of the focused window (golden ratio)
        ui = {
          signcolumn = false, -- Hide signcolumn in unfocused windows
        },
      }
    end,
  },
  --
  {
    'yioneko/nvim-vtsls',
    ft = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      local lspconfig = require 'lspconfig'
      local lspconfig_util = require 'lspconfig.util'

      -- 1. CRITICAL: Override the default lspconfig definition with the plugin's version
      -- This ensures the extra commands (VtsExec) and correct capabilities are loaded.
      require('lspconfig.configs').vtsls = require('vtsls').lspconfig

      -- 2. Define the filter for unused variables (your custom logic)
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

      -- 3. Setup the server
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

          -- VTSLS Specific Mappings
          map('n', '<leader>oi', '<cmd>VtsExec organize_imports<CR>', opts)
          map('n', '<leader>os', '<cmd>VtsExec sort_imports<CR>', opts)
          map('n', '<leader>ru', '<cmd>VtsExec remove_unused<CR>', opts)
          map('n', '<leader>ri', '<cmd>VtsExec remove_unused_imports<CR>', opts)
          map('n', '<leader>am', '<cmd>VtsExec add_missing_imports<CR>', opts)
          map('n', '<leader>fa', '<cmd>VtsExec fix_all<CR>', opts)
          map('n', '<leader>gtsd', '<cmd>VtsExec go_to_source_definition<CR>', opts)

          -- Standard LSP Mappings
          map('n', '<leader>rn', vim.lsp.buf.rename, opts)

          -- FORCE "Find References" to use built-in LSP if Telescope is failing
          map('n', 'gr', vim.lsp.buf.references, opts)
        end,
      }
    end,
  },

  -- {
  --   'pmizio/typescript-tools.nvim',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'neovim/nvim-lspconfig',
  --   },
  --
  --   config = function()
  --     local lspconfig_util = require 'lspconfig.util'
  --
  --     require('typescript-tools').setup {
  --       -- Force the real monorepo root
  --       root_dir = lspconfig_util.root_pattern('.git', 'tsconfig.json'),
  --
  --       handlers = {
  --         ['textDocument/publishDiagnostics'] = function(err, result, ctx, config)
  --           if result.diagnostics then
  --             local ignored_codes = {
  --               [6133] = true, -- 'x' is declared but never read
  --               [6192] = true, -- All imports in import declaration are unused
  --               [6196] = true, -- 'x' is declared but never used
  --               [6198] = true, -- All destructured elements are unused
  --             }
  --             local new_diagnostics = {}
  --             for _, diagnostic in ipairs(result.diagnostics) do
  --               if not ignored_codes[diagnostic.code] then
  --                 table.insert(new_diagnostics, diagnostic)
  --               end
  --             end
  --             result.diagnostics = new_diagnostics
  --           end
  --
  --           vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx, config)
  --         end,
  --       },
  --
  --       on_attach = function(_, bufnr)
  --         local map = vim.keymap.set
  --         local opts = { buffer = bufnr, silent = true }
  --
  --         -- Imports
  --         map('n', '<leader>oi', '<cmd>TSToolsOrganizeImports<CR>', opts)
  --         map('n', '<leader>os', '<cmd>TSToolsSortImports<CR>', opts)
  --         map('n', '<leader>ru', '<cmd>TSToolsRemoveUnused<CR>', opts)
  --         map('n', '<leader>ri', '<cmd>TSToolsRemoveUnusedImports<CR>', opts)
  --         map('n', '<leader>am', '<cmd>TSToolsAddMissingImports<CR>', opts)
  --
  --         -- Fixes & navigation
  --         map('n', '<leader>fa', '<cmd>TSToolsFixAll<CR>', opts)
  --         map('n', '<leader>gtsd', '<cmd>TSToolsGoToSourceDefinition<CR>', opts)
  --
  --         -- Standard LSP
  --         map('n', '<leader>rn', vim.lsp.buf.rename, opts)
  --       end,
  --     }
  --   end,
  -- },

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
      -- 1. Configure the icons to be minimal circles
      icons = {
        -- Use a dot for the close button or modified status
        button = '●',
        modified = { button = '●' },

        -- Optional: Hide filetype icons if you want ONLY the circle
        -- filetype = { enabled = false },

        -- Configure separators to be clean/invisible if desired
        separator = { left = ' ', right = '' },

        -- Set inactive/visible states to be more subtle if needed
        inactive = { button = '○' }, -- Hollow circle for inactive?
      },
    },
    config = function(_, opts)
      require('barbar').setup(opts)

      -- 2. THE IMPORTANT PART: Color the Active Tab's Circle Green
      -- We customize the highlight groups to make the active components green.

      -- local fg_green = '#9ece6a' -- TokyoNight Green (Adjust hex to your preference)
      -- local bg_active = '#2e3c64' -- Adjust to match your theme's active tab background

      -- Color the "button" (the circle) Green on the Active Tab
      -- vim.api.nvim_set_hl(0, 'BufferCurrentBtn', { fg = fg_green, bg = bg_active })
      --
      -- -- If you want the modified indicator to be green as well
      -- vim.api.nvim_set_hl(0, 'BufferCurrentMod', { fg = fg_green, bg = bg_active })
      --
      -- -- Optional: If you want the file icon itself to be green on the active tab
      -- vim.api.nvim_set_hl(0, 'BufferCurrentIcon', { fg = fg_green, bg = bg_active })
    end,
  },
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

  {
    'ray-x/lsp_signature.nvim',
    event = 'VeryLazy',
    config = function()
      require('lsp_signature').setup {
        bind = true,
        handler_opts = { border = 'rounded' },
      }
    end,
  },

  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = '<M-l>', -- Alt+l to accept (prevents clashes with nvim-cmp)
            next = '<M-]>',
            prev = '<M-[>',
          },
        },
        panel = { enabled = false },
      }
    end,
  },

  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
      { '<leader>gf', '<cmd>LazyGitCurrentFile<cr>', desc = 'LazyGit (Current File)' },
      { '<leader>gc', '<cmd>LazyGitFilter<cr>', desc = 'LazyGit (Commits)' },
    },
  },
  {
    'stevearc/aerial.nvim',
    event = 'VeryLazy',
    opts = {
      backends = { 'lsp', 'treesitter', 'markdown', 'man' },

      layout = {
        resize_to_content = false,
        -- Places the window on the right (matching your screenshot)
        default_direction = 'left',

        -- a bit wider than default to fit long Java Class names
        max_width = { 40, 0.2 },
        min_width = 20,

        -- When you jump to a symbol, flash the line so you see where you landed
        preserve_equality = true,
      },

      -- ICONS & GUIDES:
      -- Use the Nerd Font icons you already have
      nerd_font = true,
      show_guides = true,

      -- FILTERING (The most important part for you):
      -- In your screenshot, you see 'if', 'else', 'repeat'.
      -- This config filters those out so you only see Classes, Functions, and Variables.
      -- This makes navigating large Spring Boot files much faster.
      filter_kind = {
        'Class',
        'Constructor',
        'Enum',
        'Function',
        'Interface',
        'Module',
        'Method',
        'Struct',
        'Variable', -- Include this if you want to see class fields
      },

      -- NAVIGATION:
      -- Keymaps specifically for inside the Aerial window
      keymaps = {
        ['?'] = 'actions.show_help',
        ['<CR>'] = 'actions.jump', -- Jump to symbol
        ['<2-LeftMouse>'] = 'actions.jump',
        ['<C-v>'] = 'actions.jump_vsplit', -- Open symbol in vertical split
        ['<C-s>'] = 'actions.jump_split', -- Open symbol in horizontal split
        ['p'] = 'actions.scroll', -- Preview symbol code without moving
      },

      -- AUTOMATION:
      -- Automatically close the aerial window after you select a symbol?
      -- Set to 'true' if you want it to disappear after use.
      close_on_select = false,
    },
    -- KEYBINDING:
    -- AstroNvim usually maps this to '<leader>lS', but this adds a shorter one: '<leader>a'
    keys = {
      { '<leader>at', '<cmd>AerialToggle<cr>', desc = 'Toggle Aerial (Symbols)' },
    },
  },
  { 'projekt0n/github-nvim-theme', name = 'github-theme' },
  {
    'sphamba/smear-cursor.nvim',

    opts = {
      -- Smear cursor when switching buffers or windows.
      smear_between_buffers = true,

      -- Smear cursor when moving within line or to neighbor lines.
      -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
      smear_between_neighbor_lines = true,

      -- Draw the smear in buffer space instead of screen space when scrolling
      scroll_buffer_space = true,

      -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
      -- Smears and particles will look a lot less blocky.
      legacy_computing_symbols_support = false,

      -- Smear cursor in insert mode.
      -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
      smear_insert_mode = true,
      cursor_color = '#d3cdc3',
    },
  },
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
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
      -- {
      --   '<leader>cs',
      --   '<cmd>Trouble symbols toggle focus=false<cr>',
      --   desc = 'Symbols (Trouble)',
      -- },
      -- {
      --   '<leader>cl',
      --   '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      --   desc = 'LSP Definitions / references / ... (Trouble)',
      -- },
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

  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neogit',

  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },
  --
  -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
  -- Or use telescope!
  -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
  -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
