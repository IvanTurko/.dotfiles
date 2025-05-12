local params = {
  border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
}

return function()
  vim.lsp.buf.hover(params)
end
