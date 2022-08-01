if not pcall(require, "fine-cmdline") then
  return
end

require("fine-cmdline").setup {
  cmdline = {
    prompt = " ",
  },
  popup = {
    position = {
      row = "50%",
      col = "50%",
    },
    size = {
      width = "50%",
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  },
}
