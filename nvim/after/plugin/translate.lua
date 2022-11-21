if not plugins_ok "translate" then
  return
end

require("user.utils.globals").set("", {
  deepl_api_auth_key = os.getenv "DEEPL_API_KEY",
})

require("translate").setup {
  default = {
    command = "deepl_free",
  },
}
