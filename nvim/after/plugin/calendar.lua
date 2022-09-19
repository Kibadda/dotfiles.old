if not GetGlobal("loaded", "calendar") then
  return
end

vim.cmd.Dotenv "~/.dotfiles/.env"

SetGlobal("calendar", {
  locale = "de",
  first_day = "monday",
  date_endian = "little",
  date_separator = ".",
  date_month_name = true,
  date_full_month_name = true,
  week_number = true,
  frame = "default",
  google_calendar = true,
  google_api_key = Env "CALENDAR_GOOGLE_API_KEY",
  google_client_id = Env "CALENDAR_GOOGLE_CLIENT_ID",
  google_client_secret = Env "CALENDAR_GOOGLE_CLIENT_SECRET",
})

RegisterKeymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    C = { "<Plug>(calendar)", "Open calendar" },
  },
}
