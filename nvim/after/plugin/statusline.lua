if not pcall(require, "el") then
  return
end

RELOAD "el"
require("el").reset_windows()

vim.opt.laststatus = 3

local builtin = require "el.builtin"
local extensions = require "el.extensions"
local sections = require "el.sections"
local subscribe = require "el.subscribe"

local git_icon = subscribe.buf_autocmd("el_file_icon", "BufRead", function(_, bufnr)
  local icon = extensions.file_icon(_, bufnr)
  if icon then
    return icon .. " "
  end

  return ""
end)

local git_branch = subscribe.buf_autocmd("el_git_branch", "BufEnter", function(window, buffer)
  local branch = extensions.git_branch(window, buffer)
  if branch then
    return " " .. extensions.git_icon() .. " " .. branch
  end
end)

local git_changes = subscribe.buf_autocmd("el_git_changes", "BufWritePost", function(window, buffer)
  return extensions.git_changes(window, buffer)
end)

require("el").setup {
  generator = function()
    local mode = extensions.gen_mode { format_string = " %s " }

    local items = {
      { mode, required = true },
      { git_branch },
      { " " },
      { sections.split, required = true },
      { git_icon },
      { sections.maximum_width(builtin.make_responsive_file(140, 90), 0.40), required = true },
      { sections.collapse_builtin { { " " }, { builtin.modified_flag } } },
      { sections.split, required = true },
      { git_changes },
      { "[" },
      { builtin.line_with_width(3) },
      { ":" },
      { builtin.column_with_width(2) },
      { "]" },
      { sections.collapse_builtin { "[", builtin.help_list, builtin.readonly_list, "]" } },
      { builtin.filetype },
    }

    local result = {}
    for _, item in ipairs(items) do
      table.insert(result, item)
    end

    return result
  end,
}
