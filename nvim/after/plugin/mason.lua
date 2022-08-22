if not pcall(require, "mason") then
  return
end

require("mason").setup {}
require("mason-lspconfig").setup {
  ensure_installed = {
    "sumneko_lua",
    "stylua",
  }
}

require("which-key").register({
  M = { "<Cmd>Mason<CR>", "Mason" },
}, {
  prefix = "<Leader>",
})
