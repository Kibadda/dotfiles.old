if not PluginsOk "lualine" then
  return
end

require("lualine").setup {
  options = {
    theme = "gruvbox-material",
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      "mode",
    },
    lualine_b = {
      { "branch" },
      { "diff" },
      { "diagnostics" },
    },
    lualine_c = {
      function()
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
        if vim.bo.filetype == "term" then
          local split = vim.split(filename, ":", { plain = true })
          filename = split[#split]
        end

        return filename
      end,
    },
    lualine_x = {
      {
        require("noice").api.status.mode.get,
        cond = require("noice").api.status.mode.has,
      },
      "filetype",
      {
        function()
          local msg = "LS inactive"
          local buf_clients = vim.lsp.get_active_clients { bufnr = 0 }
          if next(buf_clients) == nil then
            return msg
          end
          local buf_client_names = {}

          for _, client in pairs(buf_clients) do
            if client.name ~= "null-ls" then
              table.insert(buf_client_names, client.name)
            end
          end

          local sources = {}
          for _, source in pairs(require("null-ls.sources").get_available(vim.bo.filetype)) do
            table.insert(sources, source.name)
          end

          vim.list_extend(buf_client_names, sources, 1, #sources)

          return ("[%s]"):format(table.concat(buf_client_names, ", "))
        end,
        color = { gui = "bold" },
      },
    },
    lualine_y = {
      {
        function()
          return (" Format: %s"):format(GetGlobal("Lsp", "auto_format") == 1 and " " or " ")
        end,
        color = function()
          return { fg = GetGlobal("Lsp", "auto_format") == 1 and "#A9B665" or "#EA6962" }
        end,
      },
    },
    lualine_z = {
      function()
        return require("battery").get_status_line()
      end,
      function()
        local cursor = vim.api.nvim_win_get_cursor(0)
        return string.format("%03d:%03d", cursor[1], cursor[2] + 1)
      end,
      function()
        local line = vim.api.nvim_win_get_cursor(0)[1]
        local total = vim.api.nvim_buf_line_count(0)
        if line == 1 then
          return "Top"
        end
        if line == total then
          return "Bot"
        end
        local percentage = math.floor((line / total) * 100)
        return ("%02d%%%%"):format(percentage)
      end,
    },
  },
}
