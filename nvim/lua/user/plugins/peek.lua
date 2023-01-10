local M = {
  "toppair/peek.nvim",
  build = "deno task --quiet build:fast",
}

function M.config()
  require("peek").setup {
    update_on_change = false,
  }

  require("user.utils.register").keymaps {
    n = {
      ["<Leader>"] = {
        m = {
          name = "Markdown",
          p = { require("peek").open, "Start" },
          s = { require("peek").close, "Stop" },
        },
      },
    },
  }
end

return M
