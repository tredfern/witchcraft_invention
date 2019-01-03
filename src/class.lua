-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = {}

function class:create(base)
  local c = base or {}
  setmetatable(c, self)
  self.__index = self

  function c:new(o)
    local instance = o or {}
    setmetatable(instance, c)
    return instance
  end
  return c
end

function class:is(typeof)
  return self.type_name == typeof.type_name
end

return function(className, base_class)
  if base_class then
    return class:create(base_class)
  else
    return class:create({ type_name = className })
  end

end
