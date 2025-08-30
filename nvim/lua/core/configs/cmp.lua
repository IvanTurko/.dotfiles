local cmp = require "cmp"

local options = {
  completion = {
    scrollbar = false,
    side_padding = 1,
    winhighlight = "Normal:CmpPmenu,CursorLine:CmpSel,Search:None,FloatBorder:CmpBorder",
    border = "single",
  },

  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },

  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),

    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },

  window = {
    documentation = cmp.config.disable,
  },

  sources = {
    { name = "nvim_lsp", priority = 1000, group_index = 1 },
    { name = "luasnip", priority = 900, group_index = 1 },
    { name = "nvim_lua", priority = 800, group_index = 1 },
    { name = "path", priority = 700, group_index = 2 },
    { name = "buffer", priority = 600, group_index = 2 },
  },
}

cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
  sources = {
    { name = "vim-dadbod-completion", priority = 1000, group_index = 1 },
    { name = "luasnip", priority = 800, group_index = 1 },
    { name = "buffer", priority = 700, group_index = 2 },
  },
})

cmp.setup.filetype({ "org" }, {
  sources = {
    { name = "orgmode", priority = 1000 },
    { name = "buffer", priority = 800 },
    { name = "path", priority = 700 },
  },
})

return options
