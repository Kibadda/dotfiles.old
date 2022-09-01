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
      {
        "branch",
        on_click = function()
          vim.cmd "Lazygit"
        end,
      },
      {
        "diff",
        on_click = function()
          vim.cmd "Gitsigns diffthis"
        end,
      },
      {
        "diagnostics",
        on_click = function()
          vim.cmd "Telescope diagnostics bufnr=0 theme=get_ivy"
        end,
      },
    },
    lualine_c = {
      function()
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":t")
        if vim.bo.filetype == "term" then
          local split = vim.split(filename, ":")
          filename = split[#split]
        end

        return filename
      end,
    },
    lualine_x = {
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

          vim.list_extend(buf_client_names, sources)

          return "[" .. table.concat(buf_client_names, ", ") .. "]"
        end,
        color = { gui = "bold" },
        on_click = function()
          vim.cmd "LspInfo"
        end,
      },
    },
    lualine_y = {
      {
        function()
          return " Format: " .. (GetGlobal("lsp", "auto_format") and " " or " ")
        end,
        color = function()
          return { fg = GetGlobal("lsp", "auto_format") and "#A9B665" or "#EA6962" }
        end,
        on_click = function()
          vim.cmd "ToggleAutoFormat"
        end,
      },
    },
    lualine_z = {
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
        return string.format("%02d", percentage) .. "%%"
      end,
    },
  },
  -- winbar = {
  --   lualine_z = {
  --     {
  --       "filename",
  --       path = 1,
  --     },
  --   },
  -- },
}

-- gruvbox-material theme colors
--   fg1    = '#282828',
--   color2 = '#504945',
--   fg2    = '#ddc7a1',
--   color3 = '#32302f',
--   color4 = '#a89984',
--   color5 = '#7daea3',
--   color6 = '#a9b665',
--   color7 = '#d8a657',
--   color8 = '#d3869b',
--   color9 = '#ea6962',
