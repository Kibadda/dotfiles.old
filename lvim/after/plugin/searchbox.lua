if not pcall(require, "searchbox") then
  return
end

require("searchbox").setup {
  defaults = {
    modifier = "plain",
    confirm = "menu",
  },
  popup = {
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  },
}
