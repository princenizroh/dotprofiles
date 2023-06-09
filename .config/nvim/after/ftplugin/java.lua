-- Location jdtls 
local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  vim.notify "JDTLS not found, install with `:LspInstall jdtls`"
  return
end

-- Installation location of jdtls by nvim-lsp-installer
local JDTLS_LOCATION = vim.fn.stdpath "data" .. "/lsp_servers/jdtls"

local jdtls_dir = vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls')
local config_dir = jdtls_dir .. '/config_win'
local plugins_dir = jdtls_dir .. '/plugins/'
local path_to_jar = plugins_dir .. 'org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'

local root_makers = { ".git", "mvnw", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_makers)

if root_dir == "" then
  return
end

-- Data directory
local HOME = os.getenv "HOME"
local WORKSPACE_PATH = HOME .. "/Coding/Java/"

local SYSTEM = "linux"

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local workspace_dir = WORKSPACE_PATH .. project_name

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

-- Main Config
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',   
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

    '-jar', path_to_jar,
    '-configuration', path_to_lsp_server,
    '-data', workspace_dir,
  },
  
  
  root_dir = root_dir,

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
     -- home = '/Users/ivanermolaev/Library/Java/JavaVirtualMachines/temurin-18.0.1/Contents/Home/',
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
       -- runtimes = {
        --  {
        --    name = "JavaSE-18",
         --   path = "/Users/ivanermolaev/Library/Java/JavaVirtualMachines/temurin-18.0.1/Contents/Home",
        --  },
       --   {
       --     name = "JavaSE-17",
        --    path = "/Users/ivanermolaev/Library/Java/JavaVirtualMachines/temurin-17.0.4/Contents/Home",
       --   }
      --  }
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
          url = vim.fn.stdpath "config" .. "/lang-servers/intellij-java-google-style.xml",
          profile = "GoogleStyle",
        },
      },

    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
      importOrder = {
        "java",
        "javax",
        "com",
        "org"
      },
    },
    extendedClientCapabilities = extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },

  flags = {
    allow_incremental_sync = true,
  },
   -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {},
  },
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
--jdtls.start_or_attach(config)
-- Add the commands
require('jdtls.setup').add_commands()
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
