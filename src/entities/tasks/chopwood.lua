-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local actions = require "actions"
local position = require "components.position"
local chopwood = {
  name = "task.chopwood",
  is_task = true
}

function chopwood:new(tree)
  local c = {
    target = tree,
    completed = false
  }
  setmetatable(c, self)
  self.__index = self
  return c
end

function chopwood:done()
  self.target = nil
  self.completed = true
end

function chopwood:next_action()
  if self.current_worker then
    if position.same(self.current_worker.position, self.target.position) then
    else
      return actions.move_to:new(self.current_worker, self.target.position)
    end
  end
  return nil
end

return chopwood
