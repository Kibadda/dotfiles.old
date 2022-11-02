local method

vim.ui.input({
  prompt = "Enter: ",
  default = "Basic",
}, function(input)
  method = input
end)

vim.pretty_print(method)
