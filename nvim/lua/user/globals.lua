---set global vim options
---@param options table
function SetOptions(options)
  for key, value in pairs(options) do
    vim.o[key] = value
  end
end

---set buffer local vim options
---@param options table
function SetBufferOptions(options)
  for key, value in pairs(options) do
    vim.bo[key] = value
  end
end

---set window local vim options
---@param options table
function SetWindowOptions(options)
  for key, value in pairs(options) do
    vim.wo[key] = value
  end
end
