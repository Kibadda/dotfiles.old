if not PluginsOk "nvim-lastplace" then
  return
end

require("nvim-lastplace").setup {
  lastplace_ignore_buftype = {
    "quickfix",
    "nofile",
    "help",
  },
  lastplace_ignore_filetype = {
    "gitcommit",
    "gitrebase",
  },
}
