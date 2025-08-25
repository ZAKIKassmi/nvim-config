-- Java Language Server configuration.
-- Locations:
-- 'nvim/ftplugin/java.lua'.
-- 'nvim/lang-servers/intellij-java-google-style.xml'
local function debug_log(msg, val)
  vim.notify(vim.inspect(val and val or msg), vim.log.levels.INFO)
end
local jdtls_ok, jdtls = pcall(require, 'jdtls')
if not jdtls_ok then
  vim.notify 'JDTLS not found, install with `:Mason` and install jdtls'
  return
end

-- Direct Mason path (we know this works from your earlier confirmation)
local jdtls_install_path = vim.fn.stdpath 'data' .. '/mason/packages/jdtls'

-- Determine OS config directory
local config_dir = 'config_linux'
if vim.fn.has 'macunix' == 1 then
  config_dir = 'config_mac'
elseif vim.fn.has 'win32' == 1 then
  config_dir = 'config_win'
end

-- Get Java path - use system Java instead of hardcoded macOS path
local java_cmd = vim.fn.exepath 'java'
if java_cmd == '' then
  vim.notify('Java not found in PATH. Please install Java.', vim.log.levels.ERROR)
  return
end

-- Get JAVA_HOME - try to detect it automatically
local java_home = os.getenv 'JAVA_HOME'
if not java_home then
  -- Try to find Java home automatically
  local java_version_output = vim.fn.system(java_cmd .. ' -XshowSettings:properties -version 2>&1')
  java_home = java_version_output:match 'java%.home = ([^\r\n]+)'
  if not java_home then
    java_home = vim.fn.system('dirname $(dirname $(readlink -f ' .. java_cmd .. '))')
    java_home = string.gsub(java_home, '\n', '') -- Remove newline
  end
end
-- Mason-based paths using direct path
local path_to_lsp_server = jdtls_install_path .. '/' .. config_dir
local path_to_plugins = jdtls_install_path .. '/plugins/'
local path_to_jar = vim.fn.glob(path_to_plugins .. 'org.eclipse.equinox.launcher_*.jar')
local lombok_path = jdtls_install_path .. '/lombok.jar'
local root_markers = { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }
local root_dir = require('jdtls.setup').find_root(root_markers)
if root_dir == '' then
  return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = vim.fn.stdpath 'data' .. '/site/java/workspace-root/' .. project_name
os.execute('mkdir -p ' .. workspace_dir) -- Use -p flag for Linux

-- Detect Java version for runtime configuration
local java_version = vim.fn.system(java_cmd .. ' -version 2>&1'):match 'version "(%d+)'
java_version = tonumber(java_version) or 17 -- Default to 17 if detection fails

-- Main Config
local config = {
  -- The command that starts the language server - using detected Java path
  cmd = {
    java_cmd, -- Use detected Java command instead of hardcoded macOS path
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-javaagent:' .. lombok_path,
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',

    '-jar',
    path_to_jar,
    '-configuration',
    path_to_lsp_server,
    '-data',
    workspace_dir,
  },

  root_dir = root_dir,

  -- Updated settings with detected Java home and version
  settings = {
    java = {
      home = java_home, -- Use detected Java home instead of macOS path
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = 'interactive',
        runtimes = {
          -- Dynamic runtime configuration based on detected Java
          {
            name = 'JavaSE-' .. java_version,
            path = java_home,
            default = true,
          },
        },
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
        settings = {
          url = vim.fn.stdpath 'config' .. '/lang-servers/intellij-java-google-style.xml',
          profile = 'GoogleStyle',
        },
      },
      compile = {
        nullAnalysis = {
          mode = 'automatic',
        },
      },
      codeGeneration = {
        toString = {
          template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
        },
        useBlocks = true,
        generateComments = false, -- Better for Lombok
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        'org.hamcrest.MatcherAssert.assertThat',
        'org.hamcrest.Matchers.*',
        'org.hamcrest.CoreMatchers.*',
        'org.junit.jupiter.api.Assertions.*',
        'java.util.Objects.requireNonNull',
        'java.util.Objects.requireNonNullElse',
        'org.mockito.Mockito.*',
        -- Spring Boot additions
        'org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*',
        'org.springframework.test.web.servlet.result.MockMvcResultMatchers.*',
      },
      importOrder = {
        'java',
        'javax',
        'com',
        'org',
      },
    },
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
  },

  flags = {
    allow_incremental_sync = true,
  },

  init_options = {
    bundles = {},
    extendedClientCapabilities = {
      progressReportProvider = false,
      classFileContentsSupport = true,
      overrideMethodsPromptSupport = true,
      hashCodeEqualsPromptSupport = true,
      advancedOrganizeImportsSupport = true,
      advancedGenerateAccessorsSupport = true,
      generateToStringPromptSupport = true,
      advancedExtractRefactoringSupport = true,
      inferSelectionSupport = { 'extractMethod', 'extractVariable', 'extractField' },
    },
  },
}

-- Add debugger and test bundles if available
local bundles = {}
local mason_path = vim.fn.stdpath 'data' .. '/mason/'

-- Add Java Debug Adapter
local debug_adapter_path = mason_path .. 'packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar'
vim.list_extend(bundles, vim.split(vim.fn.glob(debug_adapter_path), '\n'))

-- Add Java Test Runner
local test_runner_path = mason_path .. 'packages/java-test/extension/server/*.jar'
vim.list_extend(bundles, vim.split(vim.fn.glob(test_runner_path), '\n'))

-- Add Lombok to bundles for additional support
if vim.fn.filereadable(lombok_path) == 1 then
  table.insert(bundles, lombok_path)
end

config.init_options.bundles = bundles

config['on_attach'] = function(_, bufnr)
  -- Setup DAP if available
  local dap_ok, jdtls_dap = pcall(require, 'jdtls.dap')
  if dap_ok then
    jdtls_dap.setup_dap { hotcodereplace = 'auto', config_overrides = {} }
  end

  -- Java-specific keymaps
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set('n', '<leader>jo', jdtls.organize_imports, opts)
  vim.keymap.set('n', '<leader>jv', jdtls.extract_variable, opts)
  vim.keymap.set('n', '<leader>jc', jdtls.extract_constant, opts)
  vim.keymap.set('v', '<leader>jm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], opts)
  vim.keymap.set('n', '<leader>jr', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>jt', jdtls.test_class, opts)
  vim.keymap.set('n', '<leader>jn', jdtls.test_nearest_method, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

  -- Optional: Setup lsp_signature if available
  local sig_ok, lsp_signature = pcall(require, 'lsp_signature')
  if sig_ok then
    lsp_signature.on_attach({
      bind = true,
      floating_window_above_cur_line = false,
      padding = '',
      handler_opts = {
        border = 'rounded',
      },
    }, bufnr)
  end
end

-- Start or attach to JDTLS
require('jdtls').start_or_attach(config)
