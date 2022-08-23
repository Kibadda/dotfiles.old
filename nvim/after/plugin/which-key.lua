if not pcall(require, "which-key") then
  return
end

require("which-key").setup {
  spelling = {
    enabled = true,
    suggestions = 20,
  },
  window = {
    border = "single",
  },
}
