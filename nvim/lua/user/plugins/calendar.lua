local M = {
  "itchyny/calendar.vim",
  dependencies = {
    "tpope/vim-dotenv",
  },
}

function M.config()
  local envfile = "~/.dotfiles/.env"
  if vim.fn.filereadable(vim.fn.expand(envfile)) == 0 then
    return
  end

  vim.cmd.Dotenv(envfile)

  require("user.utils.globals").set("calendar", {
    locale = "de",
    first_day = "monday",
    date_endian = "little",
    date_separator = ".",
    date_month_name = true,
    date_full_month_name = true,
    week_number = true,
    frame = "default",
    google_calendar = true,
    google_api_key = vim.env.CALENDAR_GOOGLE_API_KEY,
    google_client_id = vim.env.CALENDAR_GOOGLE_CLIENT_ID,
    google_client_secret = vim.env.CALENDAR_GOOGLE_CLIENT_SECRET,
  })

  require("user.utils.register").keymaps {
    n = {
      ["<Leader>"] = {
        C = { "<Plug>(calendar)", "Open calendar" },
      },
    },
  }
end

return M
