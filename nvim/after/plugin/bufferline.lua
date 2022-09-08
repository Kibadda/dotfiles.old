if not PluginsOk "bufferline" then
  return
end

require("bufferline").setup {
  options = {
    show_buffer_close_icons = false,
    show_close_icon = false,
    right_mouse_command = "",
    left_mouse_command = "",
    separator_style = { "|", "|" },
    indicator = {
      -- style = "underline", -- Highlight not working correctly
      style = "none",
    },
    truncate_names = false,
    name_formatter = function(buf)
      if vim.bo.filetype == "term" then
        local split = vim.split(buf.name, ":")
        return split[#split]
      end
    end,
    custom_filter = function(buf_number)
      if vim.bo[buf_number].filetype ~= "qf" then
        return true
      end
    end,
  },
}

RegisterKeymaps {
  mode = "n",
  prefix = "",
  {
    H = { "<Cmd>BufferLineCyclePrev<CR>", "Buffer prev" },
    L = { "<Cmd>BufferLineCycleNext<CR>", "Buffer next" },
  },
}
