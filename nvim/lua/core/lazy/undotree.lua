return {
  "mbbill/undotree",
  event = "User BufInitialized",
  config = function()
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
  end,
}
