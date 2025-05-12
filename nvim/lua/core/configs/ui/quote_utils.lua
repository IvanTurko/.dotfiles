local M = {}

M.align = function(lines)
  local max_width = 0
  for _, line in ipairs(lines) do
    local width = vim.fn.strdisplaywidth(line)
    if width > max_width then
      max_width = width
    end
  end

  for i, line in ipairs(lines) do
    local pad = max_width - vim.fn.strdisplaywidth(line)
    lines[i] = line .. string.rep(" ", pad)
  end

  return lines
end

M.format_footer = function(text, max_width, overshoot)
  local width_limit = max_width + (overshoot or 5)
  local result = {}

  while #text > 0 do
    local display_len = vim.fn.strdisplaywidth(text)
    if display_len <= width_limit then
      table.insert(result, text)
      break
    end

    local idx = width_limit
    while idx > 1 and text:sub(idx, idx) ~= " " do
      idx = idx - 1
    end

    if idx == 1 then
      idx = width_limit
    end

    local line = vim.trim(text:sub(1, idx))
    table.insert(result, line)
    text = vim.trim(text:sub(idx + 1))
  end

  return result
end

return M
