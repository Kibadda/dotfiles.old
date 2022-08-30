if not PluginsOk "nvim-lastplace" then
  return
end

SetGlobal("lastplace", {
  ignore_buftype = {
    "quickfix",
    "nofile",
    "help",
  },
  ignore_filetype = {
    "gitcommit",
    "gitrebase",
  },
})
require("nvim-lastplace").setup {}
