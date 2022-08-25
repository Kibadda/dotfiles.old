if not pcall(require, "neoscroll") then
  return
end

require("neoscroll").setup {
  mappings = {
    "<C-u>",
    "<C-d>",
    "zt",
    "zz",
    "zb",
  },
}

RegisterKeymaps("n", "", {
  ["<C-u>"] = { "Scroll cursor up" },
  ["<C-d>"] = { "Scroll cursor down" },
})
