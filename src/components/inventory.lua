-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local bag = require "ext.artemis.src.bag"
local inventory = {}

function inventory:new()
  local i = {
    items = bag:new()
  }
  setmetatable(i, self)
  self.__index = self
  return i
end

function inventory:pick_up(item)
  self.items:add(item)
end

function inventory:drop()
end

return inventory
