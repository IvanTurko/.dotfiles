return {
  {
    "barrett-ruth/live-server.nvim",
    build = "npm install -g live-server",
    ft = { "html", "javascript", "markdown" },
    config = true,
  },

  {
    "IvanTurko/org-mermaid-playground.nvim",
    ft = { "org" },
    dependencies = { "barrett-ruth/live-server.nvim" },
    config = function()
      require("mermaid_playground").setup {
        workspace_dir = nil,
        index_name = "index.html",
        diagram_name = "diagram.mmd",
        overwrite_index_on_start = false,
        auto_refresh = true,
        auto_refresh_events = { "InsertLeave", "TextChanged", "TextChangedI", "BufWritePost" },
        debounce_ms = 450,
        notify_on_refresh = false,
      }
    end,
  },
}
