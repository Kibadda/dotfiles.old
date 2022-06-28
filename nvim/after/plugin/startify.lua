if not vim.g.loaded_startify then
  return
end

vim.g.startify_session_persistence = true
vim.g.startify_change_to_vcs_root = true
vim.g.startify_enable_unsafe = true

vim.g.startify_custom_header = vim.fn["startify#pad"] {
  "",
  "██╗  ██╗██╗██████╗  █████╗ ██████╗ ██████╗  █████╗",
  "██║ ██╔╝██║██╔══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗",
  "█████╔╝ ██║██████╔╝███████║██║  ██║██║  ██║███████║",
  "██╔═██╗ ██║██╔══██╗██╔══██║██║  ██║██║  ██║██╔══██║",
  "██║  ██╗██║██████╔╝██║  ██║██████╔╝██████╔╝██║  ██║",
  "╚═╝  ╚═╝╚═╝╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚═╝  ╚═╝",
  "",
}

vim.g.startify_lists = {
  { type = "sessions", header = vim.fn["startify#pad"] { "Sessions" } },
  { type = "commands", header = vim.fn["startify#pad"] { "Commands" } },
}

vim.g.startify_commands = {
  { p = "PackerSync" },
  { n = "OpenDirectory" },
}

vim.keymap.set("n", "<Leader>ss", "<CMD>SClose<CR>")

vim.api.nvim_create_user_command("OpenDirectory", function(opts)
  local input = opts.args

  if input == "" then
    input = vim.fn.input("directory: ", "", "dir")
  end

  if vim.fn.isdirectory(input) == 0 then
    vim.notify(string.format("%s is not a directory", input), "warn")
    return
  end

  vim.cmd(string.format("cd %s", input))
  vim.cmd [[term ranger]]
end, {
  bang = true,
  nargs = "?",
  desc = "Open new directory",
  complete = "dir",
})
