local M = {}

M.on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  local map = vim.keymap.set

  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map({ "n", "v" }, "<Leader>la", vim.lsp.buf.code_action, opts "Code action")

  map("n", "K", function()
    vim.lsp.buf.hover { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } }
  end, opts "Hover docs")

  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")
  map("n", "<leader>ra", vim.lsp.buf.rename, opts "Renamer")

  -- global lsp mappngs
  map("n", "<leader>ls", vim.diagnostic.setloclist, opts "diagnostic loclist")
  vim.keymap.set("n", "<leader>vd", function()
    vim.diagnostic.open_float()
  end, opts "diagnostic open float window")
end

-- disable semanticTokens
M.on_init = function(client, _)
  if client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

return M
