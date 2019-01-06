-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Label", function()
  local mock_love = require "test_helpers.mock_love"
  local Fonts = require "graphics.fonts"
  local Label = require "ui.label"
  local Colors = require "colors"

  it("creates a canvas for drawing to screen", function()
    mock_love.mock(love.graphics, "newCanvas", spy.new(function() end))
    mock_love.mock(love.graphics, "setCanvas", spy.new(function() end))
    mock_love.mock(love.graphics, "setFont", spy.new(function() end))
    mock_love.mock(love.graphics, "setColor", spy.new(function() end))
    mock_love.mock(love.graphics, "print", spy.new(function() end))
    mock_love.mock(love.graphics, "reset", spy.new(function() end))

    local l = Label:new(Fonts.title, "Title Text", 10, 30, Colors.green)
    assert.spy(love.graphics.newCanvas).was.called_with(l.font:getWidth(l.text), l.font:getHeight())
    assert.spy(love.graphics.setCanvas).was.called_with(l.image)
    assert.spy(love.graphics.setFont).was.called_with(l.font)
    assert.spy(love.graphics.setColor).was.called_with(l.color)
    assert.spy(love.graphics.print).was.called_with("Title Text", 0, 0)
    assert.spy(love.graphics.setCanvas).was.called_with(nil)
    assert.spy(love.graphics.reset).was.called()
  end)

  it("draws the canvas created to the screen at the coordinates", function()
    mock_love.mock(love.graphics, "draw", spy.new(function() end))
    local l = Label:new(Fonts.title, "Title Text", 10, 30, Colors.green)
    l:draw()
    assert.spy(love.graphics.draw).was.called_with(l.image, 10, 30)
  end)
end)
