if not pcall(require, "bufferline") then
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
      style = "none",
    },
    name_formatter = function(buf)
      if buf.name:find(":") then
        local split = vim.split(buf.name, ":")
        return split[#split]
      end
    end,
  },
}

RegisterKeymaps("", {
  H = { "<Cmd>BufferLineCyclePrev<CR>", "Buffer prev" },
  L = { "<Cmd>BufferLineCycleNext<CR>", "Buffer next" },
})
