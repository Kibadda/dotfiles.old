local M = {}

M.diagnostics = {
  static = {
    texts = {
      DiagnosticSignError = "E ",
      DiagnosticSignWarn = "W ",
      DiagnosticSignInfo = "I ",
      DiagnosticSignHint = "H ",
    },
  },
  init = function(self)
    local signs = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
      group = "*",
      lnum = vim.v.lnum,
    })

    if #signs == 0 or signs[1].signs == nil then
      self.sign = nil
      self.has_sign = false
      return
    end

    signs = vim.tbl_filter(function(sign)
      return vim.startswith(sign.group, "vim.diagnostic")
    end, signs[1].signs)

    if #signs == 0 then
      self.sign = nil
    else
      self.sign = signs[1]
    end

    self.has_sign = self.sign ~= nil
  end,
  provider = function(self)
    if self.has_sign then
      return self.texts[self.sign.name]
    end

    return "  "
  end,
  hl = function(self)
    if self.has_sign then
      return self.sign.name
    end
  end,
}

M.gitsigns = {
  init = function(self)
    local signs = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
      group = "gitsigns_vimfn_signs_",
      id = vim.v.lnum,
      lnum = vim.v.lnum,
    })

    if #signs == 0 or signs[1].signs == nil or #signs[1].signs == 0 or signs[1].signs[1].name == nil then
      self.sign = nil
    else
      self.sign = signs[1].signs[1]
    end

    self.has_sign = self.sign ~= nil
  end,
  provider = function()
    return " ▏"
  end,
  hl = function(self)
    if self.has_sign then
      return self.sign.name
    end

    return "@comment"
  end,
}

M.line_numbers = {
  provider = function()
    if vim.v.virtnum > 0 then
      return ""
    end

    if vim.v.relnum == 0 then
      return ("%02d"):format(vim.v.lnum)
    end

    return ("%02d"):format(vim.v.relnum)
  end,
}

return M
