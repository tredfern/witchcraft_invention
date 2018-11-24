-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

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
  print("adding chopwood task")
  return c
end

function chopwood:done()
  self.target = nil
  self.completed = true
end

return chopwood
