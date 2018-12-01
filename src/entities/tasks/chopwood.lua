-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local actions = require "actions"
local position = require "components.position"
local chopwood = require "entities.tasks.task":new{ name = "task.chopwood" }

function chopwood:new(tree)
  local c = {
    target = tree,
    done = false
  }
  setmetatable(c, self)
  self.__index = self
  return c
end

function chopwood:finish()
  self.target = nil
  self.done = true
end

function chopwood:next_action()
  if self.target.is_removed then
    self:finish()
    return nil
  end

  if self.current_owner then
    if not position.same(self.current_owner.position, self.target.position) then
      return actions.move_to:new(self.current_owner, self.target.position)
    else
      return actions.chop_tree:new(self.current_owner, self.target)
    end
  end
  return nil
end

return chopwood
