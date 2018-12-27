-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Logger = require "logger"
local action = {}

function action:new(settings)
  assert(settings.name, "Action requires a name")
  local a = settings
  setmetatable(a, self)
  self.__index = self
  return a
end

function action:finish()
  self.done = true
  Logger.debug:log("Action finished: %s", self.name)
end

return action
