pcall(function()
  dofile(vim.g.base46_cache .. "defaults")
  dofile(vim.g.base46_cache .. "statusline")
end)

vim.api.nvim_exec_autocmds("User", { pattern = "Base46Done" })
