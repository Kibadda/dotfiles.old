require("user.utils.register").keymaps {
  mode = "n",
  prefix = "",
  {
    ["{"] = { "<Plug>(qf_previous_file)", "QF: prev file" },
    ["}"] = { "<Plug>(qf_next_file)", "QF: next file" },
  },
}
