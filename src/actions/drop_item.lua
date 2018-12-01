-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local DropItem = require "actions.action":new{name = "drop_item"}

function DropItem:new(owner, target, notify_dropped_on)
  local di = {
    owner = owner,
    target = target,
    notify_dropped_on = notify_dropped_on
  }
  setmetatable(di, self)
  self.__index = self
  return di
end

function DropItem:execute()
  self.owner.inventory:drop(self.target)
  self.target.position:move_to(self.owner.position.x, self.owner.position.y)
  if self.notify_dropped_on then self.notify_dropped_on() end
end

return DropItem
