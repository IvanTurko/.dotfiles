local header = require "core.configs.ui.headers"
local quote_utils = require "core.configs.ui.quote_utils"

-- Get the width of the widest line in the ASCII-art header
local header_width = 0
for _, line in ipairs(header) do
  local width = vim.fn.strdisplaywidth(line)
  if width > header_width then
    header_width = width
  end
end

-- Process the quote
local quote_text = require "core.configs.ui.quotes"
local formatted_quote = quote_utils.format_footer(quote_text, header_width, 25)
local aligned_quote = quote_utils.align(formatted_quote)

-- Wrap each quote line as a `txt` object with a highlight group
local quote_blocks = {}
for _, line in ipairs(aligned_quote) do
  table.insert(quote_blocks, { txt = line, hl = "NvDashFooter" })
end

-- Add empty elements for spacing and layout alignment
local buttons = {
  { txt = " ", no_gap = true, rep = true },
  { txt = " ", no_gap = true, rep = true },
}

vim.list_extend(buttons, quote_blocks)

while #buttons <= 6 do
  table.insert(buttons, { txt = " ", no_gap = true, rep = true })
end

return {
  load_on_startup = true,
  header = header,
  buttons = buttons,
}
