local status, mason = pcall(require, "mason")
if (not status) then
  return
end

local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then
  return
end

mason.setup {
  ui = {
    check_outdated_packages_on_open = true,
    border = "single",
    width = 0.8,
    height = 0.9,
    icons = {
      package_installed = "◍",
      package_pending = "◍",
      package_uninstalled = "◍",
    },
  }
}

lspconfig.setup {
  automatic_installation = true,
}
