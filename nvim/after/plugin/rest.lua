if not PluginsOk "rest-nvim" then
  return
end

require("rest-nvim").setup {}

local function enter_auth()
  local method = vim.fn.input("method: ", "Basic")
  local username = vim.fn.input "username: "
  local password = vim.fn.input "password: "

  -- encoding
  local function enc(data)
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    return (
      (data:gsub(".", function(x)
        local r, b = "", x:byte()
        for i = 8, 1, -1 do
          r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and "1" or "0")
        end
        return r
      end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
        if #x < 6 then
          return ""
        end
        local c = 0
        for i = 1, 6 do
          c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
        end
        return chars:sub(c + 1, c + 1)
      end) .. ({ "", "==", "=" })[#data % 3 + 1]
    )
  end

  local row = vim.api.nvim_win_get_cursor(0)[1]
  vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, {
    "Authorization: " .. method .. " " .. enc(username .. ":" .. password),
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
