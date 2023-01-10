local M = {
  "akinsho/bufferline.nvim",
}

function M.config()
  require("bufferline").setup {
    options = {
      show_buffer_close_icons = false,
      show_close_icon = false,
      right_mouse_command = "",
      left_mouse_command = "",
      separator_style = "|",
      indicator = {
        style = "none",
      },
      truncate_names = false,
      custom_filter = function(buf_number)
        local filetype = vim.bo[buf_number].filetype
        return filetype ~= "qf" and filetype ~= "fugitive"
      end,
    },
  }

  require("user.utils.register").keymaps {
    n = {
      H = { "<Cmd>BufferLineCyclePrev<CR>", "Buffer prev" },
      L = { "<Cmd>BufferLineCycleNext<CR>", "Buffer next" },
    },
  }
end

return M
