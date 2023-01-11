local M = {
  "toppair/peek.nvim",
  build = "deno task --quiet build:fast",
  ft = "markdown",
}

function M.init()
  require("user.utils.register").keymaps {
    n = {
      ["<Leader>"] = {
        m = {
          name = "Markdown",
          p = {
            function()
              require("peek").open()
            end,
            "Start",
          },
          s = {
            function()
              require("peek").close()
            end,
            "Stop",
          },
        },
      },
    },
  }
end

M.opts = {
  update_on_change = false,
}

return M
