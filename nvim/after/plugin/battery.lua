if not plugins_ok "battery" then
  return
end

require("battery").setup {}
