-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("DisplayLog", function()
  local DisplayLog = require "ui.display_log"
  local mock_love = require "test_helpers.mock_love"

  it("writes out the current log to the screen when draw is called", function()
    local print_spy = spy.new(function() end)
    mock_love.override_graphics("print", print_spy)
    local l = DisplayLog:new{left = 1, top = 1, width = 20, height = 30}
    local logger = require "logger"
    logger.debug:log("Message 1")
    logger.debug:log("Message 2")
    l:draw()
    assert.spy(print_spy).was.called_with("DEBUG: Message 1", 0, l.font.height)
    assert.spy(print_spy).was.called_with("DEBUG: Message 2", 0, 0)
  end)
end)
