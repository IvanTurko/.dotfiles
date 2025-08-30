return {
  "chipsenkbeil/org-roam.nvim",
  dependencies = {
    {
      "nvim-orgmode/orgmode",
      ft = { "org" },
      config = function()
        require("orgmode").setup {
          org_agenda_files = "~/Documents/org/tasks/**/*",
          org_default_notes_file = "~/Documents/org/tasks/refile.org",
          mappings = {
            org = {
              org_toggle_checkbox = "<Leader>cc",
            },
          },
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
