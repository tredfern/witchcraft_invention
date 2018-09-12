-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local StateMachine = {}

function StateMachine:registermethod(name)
  self[name] = function(machine, ...)
    if machine.current_state and machine.current_state[name] then
      return machine.current_state[name](machine.current_state, ...)
    end

    return nil
  end
end


function StateMachine:new(methods)
  methods = methods or {}
  local sm = {}
  self.__index = self
  setmetatable(sm, self)
  for _, v in ipairs(methods) do
    sm:registermethod(v)
  end
  return sm
end


function StateMachine:change(state)
  self.current_state = state
end

return StateMachine
