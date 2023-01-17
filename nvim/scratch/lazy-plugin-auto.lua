local Set = {
  new = function(self, t)
    local set = {}
    for _, l in ipairs(t) do
      set[l] = true
    end
    return setmetatable(set, {
      __tostring = function(s)
        local str = "{"
        local sep = ""
        for e in pairs(s) do
          str = str .. sep .. e
          sep = ", "
        end
        return str .. "}"
      end,
      __add = function(a, b)
        return self:union(a, b)
      end,
      __mul = function(a, b)
        return self:intersection(a, b)
      end,
    })
  end,
  union = function(self, a, b)
    local res = self:new {}
    for _, s in ipairs { a, b } do
      for k in pairs(s) do
        res[k] = true
      end
    end
    return res
  end,
  intersection = function(self, a, b)
    local res = self:new {}
    for k in pairs(a) do
      res[k] = b[k]
    end
    return res
  end,
}

local s1 = Set:new { 10, 20, 30, 50 }
local s2 = Set:new { 30, 1 }
print(s1, s2)
print((s1 + s2) * s1)
