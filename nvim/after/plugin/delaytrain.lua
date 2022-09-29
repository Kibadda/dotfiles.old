if not PluginsOk "delaytrain" then
  return
end

require("delaytrain").setup {
  delay_ms = 1000,
  grace_period = 2,
}
