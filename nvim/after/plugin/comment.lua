if not CheckPlugin "Comment" then
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
  ignore = "^$",
}
