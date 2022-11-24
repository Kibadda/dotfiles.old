if not PluginsOk "nvim-rss" then
  return
end

require("nvim-rss").setup {
  feeds_dir = vim.fn.expand "~/.config/nvim",
}

RegisterKeymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    r = {
      name = "RSS",
      o = { require("nvim-rss").open_feeds_tab, "Open" },
      f = { require("nvim-rss").fetch_feed, "Fetch" },
      a = { require("nvim-rss").fetch_all_feeds, "Fetch all" },
      v = { require("nvim-rss").view_feed, "View" },
      C = { require("nvim-rss").clean_feed, "Clean" },
      R = { require("nvim-rss").reset_db, "Reset db" },
    },
  },
}
