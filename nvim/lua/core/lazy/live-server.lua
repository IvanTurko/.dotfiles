return {
  "selimacerbas/live-server.nvim",
  dependencies = "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader>es", "<cmd>LiveServerStart<cr>", desc = "LiveServer Start" },
    { "<leader>eo", "<cmd>LiveServerOpen<cr>", desc = "LiveServer Open" },
    { "<leader>er", "<cmd>LiveServerReload<cr>", desc = "LiveServer Reload" },
    { "<leader>et", "<cmd>LiveServerToggleLive<cr>", desc = "LiveServer Toggle" },
    { "<leader>ei", "<cmd>LiveServerStatus<cr>", desc = "LiveServer Status" },
    { "<leader>eS", "<cmd>LiveServerStop<cr>", desc = "LiveServer Stop" },
    { "<leader>eA", "<cmd>LiveServerStopAll<cr>", desc = "LiveServer Stop All" },
  },
  config = function()
    require("live_server").setup()
  end,
}
