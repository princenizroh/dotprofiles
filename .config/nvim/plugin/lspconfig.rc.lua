local status, nvim_lsp = pcall(require, "nvim-lspconfig")
if (not status) then return end

local protocol = require('vim.lsp.protocol')

-- local servers = { "clangd", "rust_analyzer", "tsserver", "sourcekit", "tailwindcss", "cssls", "astro", "lua_ls", "omnisharp", "flow" }

local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local enable_format_on_save = function(_, bufnr)
  -- format on save
  vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
  vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup_format,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format({ bufnr = bufnr })
    end,
  })
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  --local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
end

protocol.CompletionItemKind = {
  '', -- Text
  '', -- Method
  '', -- Function
  '', -- Constructor
  '', -- Field
  '', -- Variable
  '', -- Class
  'ﰮ', -- Interface
  '', -- Module
  '', -- Property
  '', -- Unit
  '', -- Value
  '', -- Enum
  '', -- Keyword
  '﬌', -- Snippet
  '', -- Color
  '', -- File
  '', -- Reference
  '', -- Folder
  '', -- EnumMember
  '', -- Constant
  '', -- Struct
  '', -- Event
  'ﬦ', -- Operator
  '', -- TypeParameter
}

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities()

nvim_lsp.flow.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

-- C++
nvim_lsp.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities
}

-- C#
-- local path_to_download = '/home/prince/.cache/omnisharp-vim/omnisharp-roslyn'
-- local omnisharp_bin = "mono /home/prince/.local/share/nvim/mason/packages/omnisharp-mono/omnisharp/Omnisharp.exe"
--
-- local pid = vim.fn.getpid()
-- local util = require 'lspconfig/util'
nvim_lsp.omnisharp.setup {
  cmd = {
    omnisharp_bin,
    -- 'mono',
    '--assembly-loader=strict',
    -- 'omnisharp-mono',
    '--languageserver',
    '--hostPID',
    tostring(vim.fn.getpid()),
    -- path_to_download .. 'omnisharp/OmniSharp.exe'
  },
  -- root_dir = nvim_lsp.util.root_patern("*.sln", "*.csproj", "*.fsproj"),
  on_attach = on_attach,
  use_mono = true,
  capabilities = capabilities, 
}

-- nvim_lsp.setup({
--   ensure_installed = servers,
-- })
--
-- for _, server in pairs(servers) do 
--   local opts = {
--     on_attach = requre("user.lsp.handlers").on_attach,
--     capabilites = require("user.lsp.handlers").capabilities,
--   }
--   local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
--   if has_custom_opts then
--     opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
--   end
--   lspconfig[server].setup(opts)
-- end
-- Lua ls
nvim_lsp.lua_ls.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    enable_format_on_save(client, bufnr)
  end,
  settings = {
    Lua = {
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },

      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false
      },
    },
  },
}
-- -- Rust
-- nvim_lsp.rust_analyzer.setup {
--   settings = {
--     ["rust-analyzer"] = {
--       assist = {
--         importGranularity = "module",
--         importPrefix = "by_self",
--       },
--       cargo = {
--         loadOutDirsFromCheck = true
--       },
--       procMacro = {
--         enable = true
--       },
--     }
--   },
--   on_attach = on_attach,
--   capabilities = capabilities
-- }
-- TypeScript
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" },
  capabilities = capabilities
}
nvim_lsp.sourcekit.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

nvim_lsp.tailwindcss.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
nvim_lsp.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

nvim_lsp.astro.setup {
  on_attach = on_attach,
  capabilities = capabilities
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    update_in_insert = false,
    virtual_text = { spacing = 4, prefix = "●" },
    severity_sort = true,
  }
)

-- Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '●'
  },
  update_in_insert = true,
  float = {
    source = "always", -- Or "if_many"
  },
})
