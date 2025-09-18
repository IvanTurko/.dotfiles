local integrations = {
  "defaults",
  "syntax",
  "treesitter",
  "cmp",

  -- extensions
  "orgmode",
}

for _, name in pairs(integrations) do
  dofile(vim.g.base46_cache .. name)
end
