-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local Queue = require "ext.artemis.src.queue"
local Logger = {}
local DEBUGLEVEL = 5
local INFOLEVEL = 3
local ERRORLEVEL = 1

Logger.formats = {
  [DEBUGLEVEL] = "DEBUG: %s",
  [INFOLEVEL] = "INFO: %s",
  [ERRORLEVEL] = "ERROR: %s"
}

Logger.messages = Queue:new()

function Logger:new(logger)
  local l = logger or { level = DEBUGLEVEL }
  setmetatable(l, self)
  self.__index = self
  return l
end

function Logger:log(message, ...)
  if Logger.log_level < self.level then return end
  local msg = Logger.formats[self.level]:format(message:format(...))
  Logger.messages:enqueue(msg)
  return msg
end

function Logger.set_log_level(level)
  Logger.log_level = level
end

Logger.set_log_level(DEBUGLEVEL)
Logger.debug = Logger:new{ level = DEBUGLEVEL }
Logger.info = Logger:new{ level = INFOLEVEL }
Logger.error = Logger:new{ level = ERRORLEVEL }

return Logger
