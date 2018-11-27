-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local pick_up = {
  name = "pick_up"
}

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
