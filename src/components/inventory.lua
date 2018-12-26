-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local List = require "ext.artemis.src.list"
local inventory = {}

function inventory:new()
  local i = {
    items = List:new()
  }
  setmetatable(i, self)
  self.__index = self
  return i
end

function inventory:pick_up(item)
  self.items:add(item)
end

function inventory:drop(item)
  self.items:remove(item)
end

function inventory:contains(item)
  return self.items:contains(item)
end

return inventory
