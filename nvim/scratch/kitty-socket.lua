vim.api.nvim_create_user_command("SetRemoteTerminalCommand", function(options)
  local socket_name = "kitty-neovim"

  vim.api.nvim_exec("!ss -l | grep '@" .. socket_name .. "'", true)
  if vim.v.shell_error == 1 then
    print "Starting terminal"
    vim.api.nvim_exec('!i3-msg exec -- kitty --listen-on="unix:@' .. socket_name .. '"', true)
  end

  require("user.utils.register").keymaps {
    n = {
      ["<Leader>"] = {
        X = {
          "<Cmd>silent !kitty @ --to=unix:@" .. socket_name .. " send-text " .. options.args .. "\\\\n<CR>",
          "Run Command",
        },
      },
    },
  }
end, {
  desc = "Run Command",
})
