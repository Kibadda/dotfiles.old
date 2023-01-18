local M = {}

M.buffer = {}
M.buffer.icon = {
  init = function(self)
    local devicons = require "nvim-web-devicons"
    local type = vim.api.nvim_buf_get_option(self.bufnr, "filetype")
    local filetype = type ~= "" and type or vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.bufnr), ":e")
    self.icon, self.highlight = devicons.get_icon_by_filetype(filetype)
    if self.icon == nil then
      local default = devicons.get_default_icon()

      self.icon = default.icon
      self.highlight = { fg = default.color }
    end
  end,
  provider = function(self)
    return self.icon
  end,
  hl = function(self)
    return self.highlight
  end,
}
M.buffer.name = {
  init = function(self)
    self.filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.bufnr), ":t")
  end,
  provider = function(self)
    return self.filename
  end,
  hl = function(self)
    if self.is_active then
      return { italic = true, bold = true }
    end

    return "@comment"
  end,
}
M.buffer.modified = {
  init = function(self)
    self.modified = vim.api.nvim_buf_get_option(self.bufnr, "modified")
    self.readonly = vim.api.nvim_buf_get_option(self.bufnr, "readonly")
    self.modifiable = vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
  end,
  provider = function(self)
    if self.modified or self.readonly or not self.modifiable then
      return "●"
    end

    return " "
  end,
  hl = function(self)
    if self.readonly or not self.modifiable then
      return { fg = self.colors.red._600 }
    elseif self.modified then
      return { fg = self.colors.green._600 }
    else
      return { bg = "" }
    end
  end,
}

M.tabpage = {
  provider = function(self)
    return "%" .. self.tabnr .. "T " .. self.tabnr .. " %T"
  end,
  hl = { bg = "" },
}

M.truncate = {}
M.truncate.right = {
  provider = "",
}
M.truncate.left = {
  provider = "",
}

return M
