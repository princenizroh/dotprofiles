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

--local has = function(x)
--	return vim.fn.has(x) == 1
--end

--local is_mac = has "macunix"
--local is_win = has "win64"

--if is_win then
--	loadfile(vim.fn.expand('~/.config/nvim/lua/windows.lua'))()
--end

--if is_mac then
--loadfile(vim.fn.expand('~/.config/nvim/lua/macos.lua'))()
--end

--vim.fn.setreg('*', 'Hello, clipboard!')
--setclipboard=unnamedplus
--vim.opt.clipboard:append("unnamedplus")
