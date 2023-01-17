local M = {}

M.buffer = {
  init = function(self)
    self.filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(self.bufnr), ":t")

    local devicons = require "nvim-web-devicons"
    local filetype = vim.api.nvim_buf_get_option(self.bufnr, "filetype") or vim.fn.fnamemodify(self.filename, ":e")
    self.icon, self.highlight = devicons.get_icon_by_filetype(filetype)
    if self.icon == nil then
      local default = devicons.get_default_icon()

      self.icon = default.icon
      self.highlight = { fg = default.color }
    end
  end,
  hl = { bg = "" },
  {
    provider = function(self)
      return self.icon
    end,
    hl = function(self)
      return self.highlight
    end,
  },
  {
    provider = function(self)
      return self.filename
    end,
    hl = function(self)
      if self.is_active then
        return { italic = true }
      end

      return {}
    end,
  },
  -- {
  --   condition = function(self)
  --     return vim.api.nvim_buf_get_option(self.bufnr, "modified")
  --   end,
  --   provider = "[+]",
  --   hl = { fg = "green" },
  -- },
  -- {
  --   condition = function(self)
  --     return not vim.api.nvim_buf_get_option(self.bufnr, "modifiable")
  --       or vim.api.nvim_buf_get_option(self.bufnr, "readonly")
  --   end,
  --   provider = "[-]",
  --   hl = { fg = "orange" },
  -- },
}

M.tabpage = {
  provider = function(self)
    return "%" .. self.tabnr .. "T " .. self.tabnr .. " %T"
  end,
  hl = { bg = "" },
}

return M
