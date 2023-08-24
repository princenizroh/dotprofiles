-- Function to create File external
local function myRequire(moduleName)
  local path = vim.fn.stdpath('config') .. '/lua/' .. moduleName .. '.lua'
  local file, err = loadfile(path)
  if file then
    return file()
  else
    print("Failed to load module: " .. err)
    return nil
  end
end

local base = myRequire("base")
local highlights = myRequire("highligts")
local has = vim.fn.has
local is_linux = has "unix"
local is_win = has "win32"
local is_wsl = has "wsl"
local maps = myRequire("maps")
local plugins = myRequire("plugins")

if is_win == 1 then
  require('windows')
end
if is_wsl == 1 then
  require('wsl')
end
if is_linux == 1 then
  require('linux')
end


-----------------Plugins-----------------
-- ale plugins
vim.g.ale_linters = {
  cs = { 'OmniSharp', 'mcs', 'mcsc' }
}
vim.g.ale_cs_mcsc_assemblies = {
  vim.fn.expand('/home/prince/Unity/Hub/Editor/2023.1.3f1/Editor/Data/Managed/UnityEngine.dll')
}
vim.g.ale_set_balloons = 1
