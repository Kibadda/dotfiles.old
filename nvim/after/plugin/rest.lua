if not PluginsOk "rest-nvim" then
  return
end

require("rest-nvim").setup {}

local function enter_auth()
  local method = vim.fn.input("method: ", "Basic")
  local username = vim.fn.input "username: "
  local password = vim.fn.input "password: "

  local data = username .. ":" .. password

  local offset = #data % 3 + 1

  local bits = string.gsub(data, ".", function(char)
    local r = ""
    local byte = string.byte(char)
    for i = 8, 1, -1 do
      r = r .. (byte % 2 ^ i - byte % 2 ^ (i - 1) > 0 and "1" or "0")
    end
    return r
  end) .. ({ "", "0000", "00" })[offset]

  local result = string.gsub(bits, "%d%d%d?%d?%d?%d?", function(bit6)
    local c = 0
    for i = 1, 6 do
      c = c + (string.sub(bit6, i, i) == "1" and 2 ^ (6 - i) or 0)
    end
    return string.sub("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/", c + 1, c + 1)
  end) .. ({ "", "==", "=" })[offset]

  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, {
    "Authorization: " .. method .. " " .. result,
  })
end

RegisterKeymaps {
  mode = "n",
  prefix = "<Leader>",
  {
    H = {
      name = "Http",
      a = { enter_auth, "Auth" },
      r = { "<Plug>RestNvim", "Run request" },
      p = { "<Plug>RestNvimPreview", "Preview command" },
      l = { "<Plug>RestNvimLast", "Run last request" },
    },
  },
}