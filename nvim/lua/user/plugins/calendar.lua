local M = {
  "itchyny/calendar.vim",
  dependencies = {
    "tpope/vim-dotenv",
  },
  cmd = "Calendar",
  enabled = false,
}

function M.init()
  require("user.utils.register").keymaps {
    n = {
      ["<Leader>"] = {
        C = { "<Plug>(calendar)", "Open calendar" },
      },
    },
  }
end

function M.config()
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
end

return M
