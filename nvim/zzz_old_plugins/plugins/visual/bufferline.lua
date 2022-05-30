vim.cmd [[highlight BufferlineOffset guifg = '#80a0ff' guibg = '#21222C']]

vim.keymap.set("n", "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>")
vim.keymap.set("n", "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>")
vim.keymap.set("n", "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>")
vim.keymap.set("n", "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>")
vim.keymap.set("n", "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>")
vim.keymap.set("n", "<leader>6", "<cmd>BufferLineGoToBuffer 6<CR>")
vim.keymap.set("n", "<leader>7", "<cmd>BufferLineGoToBuffer 7<CR>")
vim.keymap.set("n", "<leader>8", "<cmd>BufferLineGoToBuffer 8<CR>")
vim.keymap.set("n", "<leader>9", "<cmd>BufferLineGoToBuffer 9<CR>")

require("bufferline").setup {
  options = {
    indicator_icon = " ",
    offsets = {
      {
        filetype = "NvimTree",
        text = "   Files",
        highlight = "BufferlineOffset",
        text_align = "left",
      },
    },
    modified_icon = "",
    separator_style = "thin",
    show_buffer_close_icons = false,
    show_close_icon = false,
    custom_areas = {
      left = function()
        return {
          { text = "    ", guifg = "#8fff6d" },
        }
      end,
    },
  },
  highlights = {
    background = {
      guibg = { attribute = "bg", highlight = "TabLineFill" },
    },
    fill = {
      guibg = { attribute = "bg", highlight = "TabLineFill" },
    },
    tab = {
      guibg = { attribute = "bg", highlight = "TabLineFill" },
    },
    close_button = {
      guibg = { attribute = "bg", highlight = "TabLineFill" },
    },
    separator = {
      guibg = { attribute = "bg", highlight = "TabLineFill" },
    },
    modified = {
      guifg = { attribute = "fg", highlight = "DiffAdd" },
    },
    modified_selected = {
      guifg = { attribute = "fg", highlight = "DiffAdd" },
    },
  },
}
