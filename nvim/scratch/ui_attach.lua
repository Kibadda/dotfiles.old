local ns = vim.api.nvim_create_namespace "my_fancy_pum"

local function attachCmdLine()
  -- vim.ui_attach(ns, { ext_cmdline = true }, function(event, ...)
  --   local line = ""

  --   if event == "cmdline_show" then
  --     local content, pos, firstc, prompt, indent, level = ...

  --     line = firstc .. prompt .. string.rep(" ", indent)
  --     for _, c in ipairs(content) do
  --       line = line .. c[2]
  --     end

  --     vim.api.nvim_echo({ { line, "Normal" } }, false, {})
  --   end
  -- end)

  vim.ui_attach(ns, { ext_messages = true }, function(event, ...)
    if event == "msg_show" then
      local level = vim.log.levels.INFO
      local kind, content = ...
      local message = ""

      for _, c in ipairs(content) do
        message = message .. c[2]
      end
      if string.find(kind, "err") then
        level = vim.log.levels.ERROR
      end
      vim.notify(message, level, { title = "Message" })
    end
  end)
end

local function detachCmdLine()
  vim.ui_detach(ns)
end

require("user.utils.register").keymaps {
  mode = "n",
  prefix = "<C-s>",
  {
    a = { attachCmdLine, "Attach cmd" },
    d = { detachCmdLine, "Detach cmd" },
  },
}
