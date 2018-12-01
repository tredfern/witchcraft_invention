-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Task = {
  is_task = true
}

function Task:new(tbl)
  local t = tbl
  assert(t.name, "Task requires a name")
  setmetatable(t, self)
  self.__index = self
  return t
end

function Task:set_owner(owner)
  self.current_owner = owner
end

return Task
