if not pcall(require, "neoscroll") then
  return
end

require("neoscroll").setup {
  mappings = {
    "<C-u>",
    "<C-d>",
    -- "<C-b>",
    -- "<C-f>",
    -- "<C-y>",
    -- "<C-e>",
    "zt",
    "zz",
    "zb",
  },
}

RegisterKeymaps("n", "", {
  ["<C-u>"] = { "Scroll cursor up" },
  ["<C-d>"] = { "Scroll cursor down" },
  -- ["<C-b>"] = { "Scroll cursor up" },
  -- ["<C-f>"] = { "Scroll cursor down" },
  -- ["<C-y>"] = { "Scroll window up" },
  -- ["<C-e>"] = { "Scroll window down" },
})
