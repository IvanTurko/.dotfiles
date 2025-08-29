return {
  "chipsenkbeil/org-roam.nvim",
  dependencies = {
    {
      "nvim-orgmode/orgmode",
      ft = { "org" },
      config = function()
        -- Setup orgmode
        require("orgmode").setup {
          org_agenda_files = "~/Documents/org/todo/**/*",
          org_default_notes_file = "~/Documents/org/todo/refile.org",
        }
      end,
    },
  },
  config = function()
    require("org-roam").setup {
      directory = "~/Documents/org/notes",
    }
  end,
}
