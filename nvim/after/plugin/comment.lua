if not pcall(require, "Comment") then
  return
end

require("Comment").setup {
  opleader = {
    line = "gc",
    block = "gb",
  },
  mappings = {
    basic = true,
    extra = true,
    extended = true,
  },
  toggler = {
    line = "gcc",
    block = "gbc",
  },
  pre_hook = nil,
  post_hook = nil,
  ignore = "^$",
}
