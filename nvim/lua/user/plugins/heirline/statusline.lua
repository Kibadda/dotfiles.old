local M = {}

M.mode = {
  provider = function(self)
    return (" %s "):format(self.modes.names[self.mode])
  end,
  hl = function(self)
    return self.modes.colors[self.modes.names[self.mode]]
  end,
  update = { "ModeChanged" },
}

M.git = {
  init = function(self)
    self.status = vim.b.gitsigns_status_dict or {}
  end,
  {
    provider = function(self)
      return (" %s "):format(self.status.head or "no git")
    end,
  },
  {
    provider = function(self)
      return "+" .. (self.status.added or 0)
    end,
    hl = function(self)
      return { fg = self.colors.green._600 }
    end,
  },
  {
    provider = function(self)
      return "-" .. (self.status.removed or 0)
    end,
    hl = function(self)
      return { fg = self.colors.red._500 }
    end,
  },
  {
    provider = function(self)
      return "~" .. (self.status.changed or 0)
    end,
    hl = function(self)
      return { fg = self.colors.orange._500 }
    end,
  },
}

M.diagnostics = {
  init = function(self)
    for _, severity in ipairs(vim.diagnostic.severity) do
      self[severity:lower()] = #vim.diagnostic.get(0, { severity = severity })
    end
  end,
  update = { "DiagnosticChanged", "BufEnter" },
  {
    provider = function(self)
      return "E" .. (self.error < 10 and self.error or "#")
    end,
    hl = "DiagnosticSignError",
  },
  {
    provider = function(self)
      return "W" .. (self.warn < 10 and self.warn or "#")
    end,
    hl = "DiagnosticSignWarn",
  },
  {
    provider = function(self)
      return "I" .. (self.info < 10 and self.info or "#")
    end,
    hl = "DiagnosticSignInfo",
  },
  {
    provider = function(self)
      return "H" .. (self.hint < 10 and self.hint or "#")
    end,
    hl = "DiagnosticSignHint",
  },
}

M.filename = {
  init = function(self)
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
    if vim.bo.filetype == "term" then
      local split = vim.split(filename, ":", { plain = true })
      filename = split[#split]
    end

    self.filename = filename
  end,
  provider = function(self)
    return #self.filename > 0 and self.filename or vim.bo.filetype
  end,
  update = { "BufEnter" },
}

M.filetype = {
  init = function(self)
    local devicons = require "nvim-web-devicons"
    self.icon, self.highlight = devicons.get_icon_by_filetype(vim.bo.filetype)
    if self.icon == nil then
      local default = devicons.get_default_icon()

      self.icon = default.icon
      self.highlight = { fg = default.color }
    end
  end,
  {
    provider = function(self)
      return self.icon
    end,
    hl = function(self)
      return self.highlight
    end,
  },
  {
    provider = function()
      return " " .. vim.bo.filetype
    end,
    hl = { bold = false },
  },
  update = { "BufEnter" },
}

M.lsp = {
  init = function(self)
    local buf_client_names = {}

    for _, client in pairs(vim.lsp.get_active_clients { bufnr = 0 }) do
      if client.name ~= "null-ls" then
        table.insert(buf_client_names, client.name)
      end
    end

    local sources = {}
    for _, source in pairs(require("null-ls.sources").get_available(vim.bo.filetype)) do
      table.insert(sources, source.name)
    end

    self.servers = vim.list_extend(buf_client_names, sources)
  end,
  {
    provider = function(self)
      return #self.servers > 0 and table.concat(self.servers, ", ") or "LS inactive"
    end,
    hl = { bold = true, fg = nil },
  },
  update = { "LspAttach", "LspDetach" },
}

M.formatting = {
  {
    provider = function()
      return ("Format: %s"):format(vim.g.LspAutoFormat == 1 and " " or " ")
    end,
    hl = function(self)
      return { fg = vim.g.LspAutoFormat == 1 and self.colors.green._600 or self.colors.red._600 }
    end,
  },
}

M.position = {
  init = function(self)
    self.cursor = vim.api.nvim_win_get_cursor(0)
  end,
  hl = function(self)
    return self.modes.colors[self.modes.names[vim.fn.mode()]]
  end,
  {
    provider = function(self)
      local line = self.cursor[1]
      local total = vim.api.nvim_buf_line_count(0)
      local percentage
      if line == 1 then
        percentage = "Top"
      elseif line == total then
        percentage = "Bot"
      else
        percentage = ("%02d%%%%"):format(math.floor((line / total) * 100))
      end
      return (" %03d:%03d | %s "):format(self.cursor[1], self.cursor[2] + 1, percentage)
    end,
  },
}

return M
