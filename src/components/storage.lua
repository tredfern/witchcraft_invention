-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local List = require "ext.artemis.src.list"
local Storage = {}

function Storage:new()
  local s = {
    items = List:new()
  }
  setmetatable(s, self)
  self.__index = self
  return s
end

function Storage:add(item)
  self.items:add(item)
end

function Storage:remove(item)
  self.items:remove(item)
end

function Storage:contains(item)
  return self.items:contains(item)
end

return Storage
