return {
  "chipsenkbeil/org-roam.nvim",
  dependencies = {
    {
      "nvim-orgmode/orgmode",
      ft = { "org" },
      config = function()
        vim.api.nvim_create_autocmd("FileType", {
          pattern = "org",
          callback = function()
            vim.opt_local.conceallevel = 2
            vim.opt_local.concealcursor = "nc"
          end,
        })

        require("orgmode").setup {
          org_agenda_files = {
            "~/Documents/org/tasks/**/*",
            "~/Documents/projects/**/*",
          },
          org_default_notes_file = "~/Documents/org/tasks/refile.org",
          org_hide_emphasis_markers = true,
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
      templates = {
        d = {
          description = "default",
          template = "#+DATE: %U\n#+AUTHOR: Ivan Turko\n\n%?",
          target = "%<%Y%m%d%H%M%S>-%[slug].org",
        },
      },
    }
  end,
}
