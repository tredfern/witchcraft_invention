-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = {}

function class:create(typename)
end

function class:new(tbl)
  local instance = tbl or {}
  setmetatable(instance, self)
  self.__index = self
  return instance
end

function class:is(typeof)
  return self.type_name == typeof.type_name
end


return function(className)
  return class:new({
    type_name = className
  })
end
