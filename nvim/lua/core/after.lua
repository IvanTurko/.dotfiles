pcall(function()
  dofile(vim.g.base46_cache .. "defaults")
end)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    -- Link netrw directory classifications to Directory highlight
    vim.api.nvim_set_hl(0, "netrwClassify", { link = "Directory" })
  end,
})
