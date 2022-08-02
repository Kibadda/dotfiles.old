if not pcall(require, "fine-cmdline") then
  return
end

require("fine-cmdline").setup {
  cmdline = {
    prompt = " ",
  },
  popup = {
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  },
}
