local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  }
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("user.plugins", {
  defaults = {
    lazy = true,
  },
  dev = {
    pattern = { "Kibadda" },
    path = "~/plugins",
  },
  install = {
    -- missing = false,
    colorscheme = { "tundra" },
  },
  ui = {
    border = "single",
    ---@type table<string, fun(plugin: LazyPlugin)>
    custom_keys = {
      t = function(plugin)
        require("lazy.util").float_term(nil, {
          cwd = plugin.dir,
        })
      end,
    },
  },
  diff = {
    cmd = "terminal_git",
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
