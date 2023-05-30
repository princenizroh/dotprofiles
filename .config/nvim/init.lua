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
local maps = myRequire("maps")
local plugins = myRequire("plugins")

local has = vim.fn.has

local is_win = has "win32"
local is_wsl = has "wsl"

if is_win == 1 then
  require('windows')
end
if is_wsl == 1 then
  require('wsl')
end
--vim.fn.setreg('*', 'Hello, clipboard!')
--setclipboard=unnamedplus
--vim.opt.clipboard:append("unnamedplus")
