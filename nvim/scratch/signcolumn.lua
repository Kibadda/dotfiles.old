_G.StatusColumn = {
  numbers = {
    provider = function()
      if vim.v.relnum ~= 0 then
        return " %r"
      else
        return " %l"
      end
    end,
  },
  gitsigns = {
    init = function(self)
      local signs = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
        group = "gitsigns_vimfn_signs_",
        id = vim.v.lnum,
        lnum = vim.v.lnum,
      })

      if #signs == 0 or signs[1].signs == nil or #signs[1].signs == 0 or signs[1].signs[1].name == nil then
        self.has_sign = true
        self.sign = signs[1].signs[1].name
      else
        self.has_sign = false
        self.sign = nil
      end
    end,
    provider = function()
      return " ▏"
    end,
    hl = function(self)
      if not self.has_sign then
        return "%#@comment#"
      else
        return "%#" .. self.sign .. "#"
      end
    end,
  },
}

vim.opt.statuscolumn =
  [[%=%{%v:lua.StatusColumn.numbers.provider()%}%{%v:lua.StatusColumn.gitsigns.hl()%}%{v:lua.StatusColumn.gitsigns.provider()}]]
