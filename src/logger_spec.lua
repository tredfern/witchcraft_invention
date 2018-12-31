-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Logger", function()
  local Logger = require "logger"

  before_each(function()
    Logger.messages:clear()
  end)

  it("has a debug, info, and error levels", function()
    assert.not_equal(nil, Logger.debug.log)
    assert.not_equal(nil, Logger.info.log)
    assert.not_equal(nil, Logger.error.log)
  end)

  it("prepends the log level on the final message", function()
    assert.equals("ERROR: Message", Logger.error:log("Message"))
    assert.equals("INFO: Message", Logger.info:log("Message"))
    assert.equals("DEBUG: Message", Logger.debug:log("Message"))
  end)

  it("appends log messages to the global logger on logging", function()
    Logger.error:log("Message 1")
    Logger.error:log("Message 2")
    assert.equals("ERROR: Message 1", Logger.messages[1])
    assert.equals("ERROR: Message 2", Logger.messages[2])
  end)

  it("only logs when the log level is passed", function()
    Logger.set_log_level(3)
    Logger.debug:log("Message")
    assert.is_true(Logger.messages:isempty())
    Logger.error:log("Message")
    assert.equals(1, #Logger.messages)
    Logger.set_log_level(5)
    Logger.debug:log("Message")
    assert.equals(2, #Logger.messages)
  end)

  it("can provide format strings with different contents", function()
    local m = Logger.debug:log("Message %s-%s: %d", "extra", "data", 5)
    assert.equals("DEBUG: Message extra-data: 5", m)
  end)

  it("can add a log message around a method call for quicker debugging", function()
    local t = {}
    t.method = function() return 7 end
    Logger.debug:log_method(t, "method")
    assert.equals(7, t.method())
    assert.equals("DEBUG: method() called", Logger.messages[1])
  end)

  it("can log a method and tracks the arguments called", function()
    local t = {}
    t.method = function(a,b,c) return a + b + c end
    Logger.debug:log_method(t, "method")
    local result = t.method(1, 2, 3)
    assert.equals(6, result)
    assert.equals("DEBUG: method(1, 2, 3) called", Logger.messages[1])
  end)

  it("can handle tables in parameters for logging out arguments", function()
    local t = {}
    t.method = function() end
    Logger.debug:log_method(t, "method")
    assert.has_no.errors(function() t.method({}) end)
  end)
end)
