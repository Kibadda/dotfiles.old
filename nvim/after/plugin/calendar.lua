local globals = require "user.utils.globals"

if not globals.get("loaded", "calendar") then
  return
end

local envfile = "~/.dotfiles/.env"
if vim.fn.filereadable(envfile) == 0 then
  return
end

vim.cmd.Dotenv(envfile)

globals.set("calendar", {
  locale = "de",
  first_day = "monday",
  date_endian = "little",
  date_separator = ".",
  date_month_name = true,
  date_full_month_name = true,
  week_number = true,
  frame = "default",
  google_calendar = true,
  google_api_key = os.getenv "CALENDAR_GOOGLE_API_KEY",
  google_client_id = os.getenv "CALENDAR_GOOGLE_CLIENT_ID",
  google_client_secret = os.getenv "CALENDAR_GOOGLE_CLIENT_SECRET",
})

require("user.utils.register").keymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    C = { "<Plug>(calendar)", "Open calendar" },
  },
}
