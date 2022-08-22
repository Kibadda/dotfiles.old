if not pcall(require, "lualine") then
  return
end

require("lualine").setup {
  options = {
    theme = "gruvbox-material",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "filetype" },
    lualine_y = { "location" },
    lualine_z = { "progress" },
  },
}
