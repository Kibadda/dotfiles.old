if not pcall(require, "lualine") then
  return
end

require("lualine").setup {
  options = {
    theme = "gruvbox-material",
  },
  sections = {
    lualine_a = {
      "mode",
    },
    lualine_b = {
      "branch",
      "diff",
      "diagnostics",
    },
    lualine_c = {
      "filename",
    },
    lualine_x = {
      "filetype",
      {
        function()
          local msg = "LS inactive"
          local buf_clients = vim.lsp.get_active_clients()
          if next(buf_clients) == nil then
            return msg
          end
          local buf_client_names = {}

          for _, client in pairs(buf_clients) do
            table.insert(buf_client_names, client.name)
          end

          return "[" .. table.concat(buf_client_names, ", ") .. "]"
        end,
        color = { gui = "bold" },
      },
      {
        function()
          return " Format: " .. (GetGlobal("lsp", "auto_format") and " " or " ")
        end,
        color = function()
          return { fg = GetGlobal("lsp", "auto_format") and "#A9B665" or "#EA6962" }
        end,
      },
    },
    lualine_y = {
      "location",
    },
    lualine_z = {
      "progress",
    },
  },
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
