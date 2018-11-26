-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local move_to = {
  name = "move_to"
}

function move_to:new(owner, target)
  local a = {
    owner = owner,
    target = target,
    progress = 0
  }
  setmetatable(a, self)
  self.__index = self
  return a
end

function move_to:execute(dt)
  local owner = self.owner
  local target = self.target

  if self.done or owner.position:same(target) then
    self.done = true
    return
  end

  self.progress = self.progress + dt
  if self.progress >= owner.speed then
    self.progress = 0
    if owner.position.x < target.x then
      owner.position.x = owner.position.x + 1
    elseif owner.position.x > target.x then
      owner.position.x = owner.position.x - 1
    end
    if owner.position.y < target.y then
      owner.position.y = owner.position.y + 1
    elseif owner.position.y > target.y then
      owner.position.y = owner.position.y - 1
    end
  end
end

return move_to
