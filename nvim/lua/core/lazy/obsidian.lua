return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  cmd = "Obsidian",
  ft = "markdown",
  dependencies = "nvim-telescope/telescope.nvim",
  opts = {
    legacy_commands = false, -- this will be removed in 4.0.0
    ui = { enable = false },
    picker = {
      name = "telescope.nvim", -- use telescope
      -- name = "fzf-lua",     -- or fzf-lua
      -- name = "mini.pick",   -- or mini.pick
      -- name = "snacks.picker", -- or snacks picker
    },
    notes_subdir = "inbox",
    new_notes_location = "notes_subdir",
    workspaces = {
      {
        name = "org",
        path = "~/Documents/org",
      },
    },
    note_id_func = function(title)
      if not title or title == "" then
        vim.notify("YO! You forgot the title, homie! Stay creative!", vim.log.levels.WARN)
        title = "untitled"
      end

      local slug = vim.trim(title)
      slug = vim.fn.substitute(slug, "[^[:keyword:][:space:]-]", "", "g")
      slug = vim.fn.substitute(slug, "[_[:space:]]\\+", "-", "g")
      slug = vim.fn.substitute(slug, "-\\+", "-", "g")
      slug = vim.fn.substitute(slug, "^-\\+", "", "")
      slug = vim.fn.substitute(slug, "-\\+$", "", "")

      if slug == "" then
        vim.notify("YO! That title's just noise, homie! Sticking to 'untitled'.", vim.log.levels.WARN)
        slug = "untitled"
      end
      return os.date "%Y%m%d%H%M%S" .. "-" .. slug
    end,
    frontmatter = {
      func = function(note)
        local out = {
          date = os.date "%Y-%m-%d %H:%M",
          author = "Ivan Turko",
          id = note.id,
          aliases = note.aliases,
          tags = note.tags,
        }

        if note.title and note.title ~= "" then
          out.title = note.title
        else
          out.title = "Untitled"
        end

        return out
      end,
      sort = { "id", "date", "title", "author", "aliases", "tags" },
    },
  },
}
