-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local List = require "ext.artemis.src.list"
local Logger = {}
local DEBUGLEVEL = 5
local INFOLEVEL = 3
local ERRORLEVEL = 1

Logger.formats = {
  [DEBUGLEVEL] = "DEBUG: %s",
  [INFOLEVEL] = "INFO: %s",
  [ERRORLEVEL] = "ERROR: %s"
}

Logger.messages = List:new()

function Logger:new(logger)
  local l = logger or { level = DEBUGLEVEL }
  setmetatable(l, self)
  self.__index = self
  return l
end

function Logger:log(message, ...)
  if Logger.log_level < self.level then return end
  local msg = Logger.formats[self.level]:format(message:format(...))
  Logger.messages:add(msg)
  return msg
end

function Logger.set_log_level(level)
  Logger.log_level = level
end

function Logger:log_method(tbl, method_name)
  local old_method = tbl[method_name]
  tbl[method_name] = function(...)
    local arguments = ""
    for _, v in ipairs({...}) do
      arguments = arguments .. tostring(v) .. ", "
    end
    arguments = string.sub(arguments, 1, #arguments - 2)

    self:log("%s(%s) called", method_name, arguments)
    return old_method(...)
  end
end

Logger.set_log_level(DEBUGLEVEL)
Logger.debug = Logger:new{ level = DEBUGLEVEL }
Logger.info = Logger:new{ level = INFOLEVEL }
Logger.error = Logger:new{ level = ERRORLEVEL }

return Logger
