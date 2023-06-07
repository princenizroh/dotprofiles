local jdtls_dir = vim.fn.expand('~/.local/share/nvim/mason/packages/jdtls')
local config_dir = jdtls_dir .. '/config_win'
local plugins_dir = jdtls_dir .. '/plugins/'
local path_to_jar = plugins_dir .. 'org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar'

local root_makers = { ".git", "mvnw", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_makers)
if root_dir == "" then
  return
end

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
-- local workspace_dir = vim.fn.stdpath()
