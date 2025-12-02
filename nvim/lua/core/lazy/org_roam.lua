return {
  "chipsenkbeil/org-roam.nvim",
  event = "VeryLazy",
  dependencies = {
    {
      "nvim-orgmode/orgmode",
      tag = "0.7.0",
      opts = {
        org_agenda_files = {
          "~/Documents/org/tasks/**/*",
          "~/Documents/projects/**/*",
        },
        org_default_notes_file = "~/Documents/org/tasks/refile.org",
        org_todo_keywords = {
          "TODO(t)",
          "NEXT(n)",
          "IN-PROGRESS(p)",
          "HABIT(h)",
          "WAITING(w)",
          "|",
          "DONE(d)",
          "CANCELLED(c)",
        },
        org_hide_emphasis_markers = true,
        mappings = {
          org = {
            org_toggle_checkbox = "<Leader>cc",
          },
        },
        org_custom_exports = {
          t = {
            label = "PDF via Tectonic",
            action = function(exporter)
              local current_file = vim.api.nvim_buf_get_name(0)
              local pdf_file = vim.fn.fnamemodify(current_file, ":p:r") .. ".pdf"

              local command = {
                "pandoc",
                current_file,
                "-f",
                "org",
                "--to",
                "pdf",
                "-o",
                pdf_file,
                "--pdf-engine=tectonic",
                "--highlight-style=pygments",
                "--listings",
                "--variable",
                "geometry:margin=1in",
                "--variable",
                "fontsize=12pt",
                "--variable",
                "mainfont=Helvetica",
              }

              local on_success = function()
                local pdf_name = vim.fn.fnamemodify(pdf_file, ":t")
                print("PDF created: " .. pdf_name)
                vim.notify("Tectonic PDF: " .. pdf_name, vim.log.levels.INFO)

                local open_cmd = vim.fn.has "macunix" == 1 and { "open", pdf_file } or { "xdg-open", pdf_file }
                vim.defer_fn(function()
                  vim.fn.jobstart(open_cmd, { detach = true })
                end, 500)
              end

              local on_error = function(err)
                local error_msg = table.concat(err, "\n")
                print "Tectonic export failed!"
                vim.notify("Tectonic error:\n" .. error_msg, vim.log.levels.ERROR)
              end

              return exporter(command, pdf_file, on_success, on_error)
            end,
          },
        },
      },
    },
  },
  tag = "0.2.0",
  opts = {
    directory = "~/Documents/org/inbox",
    org_files = {
      "~/Documents/org",
    },
    templates = {
      d = {
        description = "default",
        template = "#+DATE: %U\n#+AUTHOR: Ivan Turko\n\n%?",
        target = "%<%Y%m%d%H%M%S>-%[slug].org",
      },
    },
  },
}
