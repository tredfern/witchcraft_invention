-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local action = require "actions.action"
local pick_up = action:new({ name = "pick_up" })

function pick_up:new(owner, target)
  local p = {
    owner = owner,
    target = target
  }
  setmetatable(p, self)
  self.__index = self
  return p
end

function pick_up:execute()
  self.owner.inventory:pick_up(self.target)
  self.done = true
end

return pick_up
