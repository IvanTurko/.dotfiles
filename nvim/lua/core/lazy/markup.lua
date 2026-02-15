return {
  "IvanTurko/markup-preview.nvim",
  dependencies = { "selimacerbas/live-server.nvim" },
  cmd = {
    "MarkupPreviewStart",
    "MarkupPreviewStop",
    "MarkupPreviewToggle",
  },
  config = function()
    require("markup_preview").setup {
      -- all optional; sane defaults shown
      port = 8421,
      open_browser = true,
      debounce_ms = 300,
    }
  end,
}
