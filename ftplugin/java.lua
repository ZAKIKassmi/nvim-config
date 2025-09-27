-- ftplugin/java.lua - Java configuration for Kickstart v3
-- Compatible with existing blink.cmp, mason, and nvim-jdtls setup

local bufnr = vim.api.nvim_get_current_buf()

-- Java-specific buffer settings
vim.bo[bufnr].tabstop = 4
vim.bo[bufnr].shiftwidth = 4
vim.bo[bufnr].expandtab = true
vim.bo[bufnr].softtabstop = 4

-- Enable folding for Java
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.foldlevel = 99

-- Only proceed with JDTLS setup if the plugin is available
local jdtls_ok, jdtls = pcall(require, 'jdtls')
if not jdtls_ok then
  -- Set up basic Java keymaps without JDTLS
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- Build and run commands
  vim.keymap.set('n', '<leader>jb', function()
    local has_mvnw = vim.fn.filereadable './mvnw' == 1
    local has_gradlew = vim.fn.filereadable './gradlew' == 1

    if has_mvnw then
      vim.cmd '!./mvnw clean compile'
    elseif has_gradlew then
      vim.cmd '!./gradlew build'
    else
      vim.cmd '!mvn clean compile'
    end
  end, { desc = 'Build Java project' })

  vim.keymap.set('n', '<leader>jr', function()
    local has_mvnw = vim.fn.filereadable './mvnw' == 1
    if has_mvnw then
      vim.cmd '!./mvnw spring-boot:run'
    else
      vim.cmd '!mvn spring-boot:run'
    end
  end, { desc = 'Run Spring Boot app' })

  return
end

local jdtls_setup = require 'jdtls.setup'

-- Function to get the project root
local function get_root_dir()
  return jdtls_setup.find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' } or vim.fn.getcwd()
end

-- Get OS-specific config
local function get_os_config()
  if vim.fn.has 'mac' == 1 then
    return 'mac'
  elseif vim.fn.has 'unix' == 1 then
    return 'linux'
  else
    return 'win'
  end
end

-- Check Mason installation
local mason_path = vim.fn.stdpath 'data' .. '/mason'
local jdtls_path = mason_path .. '/packages/jdtls'

if vim.fn.isdirectory(jdtls_path) == 0 then
  vim.notify('JDTLS not found. Run: :MasonInstall jdtls', vim.log.levels.WARN)
  return
end

local lombok_path = jdtls_path .. '/lombok.jar'

-- Workspace directory
local project_name = vim.fn.fnamemodify(get_root_dir(), ':t')
local workspace_dir = vim.fn.stdpath 'data' .. '/jdtls-workspace/' .. project_name

-- Get blink.cmp capabilities (compatible with your setup)
local blink_ok, blink = pcall(require, 'blink.cmp')
local capabilities = blink_ok and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()

-- JDTLS configuration
local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx2g',
    '-javaagent:' .. lombok_path,
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',
    '-jar',
    vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration',
    jdtls_path .. '/config_' .. get_os_config(),
    '-data',
    workspace_dir,
  },

  root_dir = get_root_dir(),

  settings = {
    java = {
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = 'interactive',
        runtimes = {
          {
            name = 'JavaSE-11',
            path = vim.fn.expand '~/.sdkman/candidates/java/11.0.20-tem/',
          },
          {
            name = 'JavaSE-17',
            path = vim.fn.expand '~/.sdkman/candidates/java/17.0.8-tem/',
          },
          {
            name = 'JavaSE-21',
            path = vim.fn.expand '~/.sdkman/candidates/java/21.0.1-tem/',
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
      },
      importOrder = {
        'java',
        'javax',
        'com',
        'org',
      },
    },
    contentProvider = { preferred = 'fernflower' },
    extendedClientCapabilities = jdtls.extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
      },
      useBlocks = true,
    },
  },

  flags = {
    allow_incremental_sync = true,
  },

  capabilities = capabilities,

  init_options = {
    bundles = {},
  },

  on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap = true, silent = true, buffer = bufnr }

    -- Java-specific JDTLS keymaps (using your keymap style)
    vim.keymap.set('n', '<leader>jo', jdtls.organize_imports, { desc = 'Java: [O]rganize imports', buffer = bufnr })
    vim.keymap.set('n', '<leader>jv', jdtls.extract_variable, { desc = 'Java: Extract [V]ariable', buffer = bufnr })
    vim.keymap.set('n', '<leader>jc', jdtls.extract_constant, { desc = 'Java: Extract [C]onstant', buffer = bufnr })
    vim.keymap.set('v', '<leader>jm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], { desc = 'Java: Extract [M]ethod', buffer = bufnr })
    vim.keymap.set('n', '<leader>jt', jdtls.test_class, { desc = 'Java: [T]est class', buffer = bufnr })
    vim.keymap.set('n', '<leader>jn', jdtls.test_nearest_method, { desc = 'Java: Test [N]earest method', buffer = bufnr })
    vim.keymap.set('n', '<leader>ju', jdtls.update_project_config, { desc = 'Java: Update [P]roject config', buffer = bufnr })

    -- Build and run commands (Spring Boot compatible)
    vim.keymap.set('n', '<leader>jb', function()
      local has_mvnw = vim.fn.filereadable './mvnw' == 1
      local has_gradlew = vim.fn.filereadable './gradlew' == 1

      if has_mvnw then
        vim.cmd '!./mvnw clean compile'
      elseif has_gradlew then
        vim.cmd '!./gradlew build'
      else
        vim.cmd '!mvn clean compile'
      end
    end, { desc = 'Java: [B]uild project', buffer = bufnr })

    vim.keymap.set('n', '<leader>jr', function()
      local has_mvnw = vim.fn.filereadable './mvnw' == 1
      if has_mvnw then
        vim.cmd '!./mvnw spring-boot:run'
      else
        vim.cmd '!mvn spring-boot:run'
      end
    end, { desc = 'Java: [R]un Spring Boot', buffer = bufnr })

    vim.keymap.set('n', '<leader>jT', function()
      local has_mvnw = vim.fn.filereadable './mvnw' == 1
      if has_mvnw then
        vim.cmd '!./mvnw test'
      else
        vim.cmd '!mvn test'
      end
    end, { desc = 'Java: Run all [T]ests', buffer = bufnr })

    -- Spring Boot specific commands
    vim.keymap.set('n', '<leader>sb', function()
      local has_mvnw = vim.fn.filereadable './mvnw' == 1
      if has_mvnw then
        vim.cmd '!./mvnw spring-boot:build-image'
      else
        vim.cmd '!mvn spring-boot:build-image'
      end
    end, { desc = 'Spring Boot: [B]uild image', buffer = bufnr })

    vim.keymap.set('n', '<leader>sd', function()
      local has_mvnw = vim.fn.filereadable './mvnw' == 1
      if has_mvnw then
        vim.cmd '!./mvnw dependency:tree'
      else
        vim.cmd '!mvn dependency:tree'
      end
    end, { desc = 'Spring Boot: Show [D]ependencies', buffer = bufnr })

    -- Auto-organize imports on save
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        if client.server_capabilities.documentFormattingProvider then
          jdtls.organize_imports()
        end
      end,
    })
  end,
}

-- Update which-key mappings for Java (since you're using which-key)
local which_key_ok, which_key = pcall(require, 'which-key')
if which_key_ok then
  which_key.add {
    { '<leader>j', group = '[J]ava', buffer = bufnr },
    { '<leader>s', group = '[S]pring Boot', buffer = bufnr },
  }
end

-- Start JDTLS
jdtls.start_or_attach(config)

-- Java-specific abbreviations for faster coding
local abbrevs = {
  ['syso'] = 'System.out.println();',
  ['sysoe'] = 'System.err.println();',
  ['psvm'] = 'public static void main(String[] args) {',
  ['fori'] = 'for (int i = 0; i < ; i++) {',
  ['fore'] = 'for ( : ) {',
}

for abbrev, expansion in pairs(abbrevs) do
  vim.api.nvim_buf_call(bufnr, function()
    vim.cmd(string.format('iabbrev <buffer> %s %s', abbrev, expansion:gsub('\n', '\\n')))
  end)
end

-- Auto-format on save (works with conform.nvim in your setup)
vim.api.nvim_create_autocmd('BufWritePre', {
  buffer = bufnr,
  callback = function()
    -- Use conform if available, otherwise fall back to LSP formatting
    local conform_ok, conform = pcall(require, 'conform')
    if conform_ok then
      conform.format { bufnr = bufnr, async = false, lsp_format = 'fallback' }
    else
      vim.lsp.buf.format { async = false }
    end
  end,
})

-- File type associations for Spring Boot files
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { 'application*.properties', 'application*.yml', 'application*.yaml' },
  callback = function()
    -- Set specific Spring Boot file handling
    vim.bo.filetype = vim.fn.expand '%:e' == 'properties' and 'conf' or 'yaml'
    -- Add Spring Boot specific snippets or settings here if needed
  end,
})

-- Enhanced Spring Boot project detection
local function is_spring_boot_project()
  local pom_exists = vim.fn.filereadable 'pom.xml' == 1
  local gradle_exists = vim.fn.filereadable 'build.gradle' == 1 or vim.fn.filereadable 'build.gradle.kts' == 1

  if pom_exists then
    local pom_content = vim.fn.readfile 'pom.xml'
    for _, line in ipairs(pom_content) do
      if string.match(line, 'spring%-boot') then
        return true
      end
    end
  end

  if gradle_exists then
    local gradle_files = vim.fn.glob('build.gradle*', false, true)
    for _, file in ipairs(gradle_files) do
      local gradle_content = vim.fn.readfile(file)
      for _, line in ipairs(gradle_content) do
        if string.match(line, 'spring%-boot') then
          return true
        end
      end
    end
  end

  return false
end

-- Show Spring Boot status in statusline if detected
if is_spring_boot_project() then
  vim.b.spring_boot_project = true
  vim.notify('Spring Boot project detected', vim.log.levels.INFO)
end
