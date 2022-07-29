vim.api.nvim_create_user_command("OpenTerminal", function(opts)
  vim.cmd(string.format("term %s", opts.args))
end, {
  bang = true,
  nargs = "?",
  desc = "Open terminal",
  complete = "shellcmd",
})

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

vim.api.nvim_create_user_command("OpenFile", function(opts)
  local input = opts.args

  if input == "" then
    input = vim.fn.input("file: ", "", "file")
  end

  vim.cmd(string.format("e %s", input))
end, {
  bang = true,
  nargs = "?",
  desc = "Open new file",
  complete = "file",
})

vim.api.nvim_create_user_command("ToggleFormatOnSave", function()
  local auto = require "lvim.core.autocmds"
  local exists, autocmds = pcall(vim.api.nvim_get_autocmds, {
    group = "lsp_format_on_save",
    event = "BufWritePre",
  })
  if not exists or #autocmds == 0 then
    auto.enable_format_on_save()
    vim.notify("Turned on", "success", { title = "Format on save" })
  else
    auto.disable_format_on_save()
    vim.notify("Turned off", "success", { title = "Format on save" })
  end
end, {
  bang = false,
  nargs = 0,
  desc = "Toggle format on save",
})

vim.api.nvim_create_user_command("BetterExplore", function()
  if vim.bo.filetype == "NvimTree" then
    vim.cmd [[NvimTreeClose]]
  else
    vim.cmd [[NvimTreeFindFile]]
  end
end, {
  bang = false,
  nargs = 0,
  desc = "If open and focused -> close otherwise -> find file",
})

vim.api.nvim_create_user_command("DetachTmux", function()
  vim.cmd [[!tmux detach]]
end, {
  bang = false,
  nargs = 0,
  desc = "Detach from tmux session",
})

vim.api.nvim_create_user_command("P", function(args)
  local expression = args.args

  if expression == "" then
    return
  end

  -- vim.cmd("lua P(" .. expression .. ")")
  local func, _ = load("return function () return " .. expression .. " end")
  if func then
    local ok, f = pcall(func)
    if ok then
      P(f())
    else
      vim.notify("Execution error", "error")
    end
  else
    vim.notify("Compilation error", "error")
  end
end, {
  bang = false,
  nargs = 1,
  desc = "Wrapper for :lua P",
  complete = "lua",
})
