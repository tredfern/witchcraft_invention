-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Window", function()
  local mock_love = require "test_helpers.mock_love"
  local Window = require "src.ui.window"

  it("has coordinates based on tile coordinates", function()
    local w = Window:new{
      left = 10,
      top = 10,
      width = 20,
      height = 20
    }
    assert.equals(10, w.left)
    assert.equals(10, w.top)
    assert.equals(20, w.width)
    assert.equals(20, w.height)
  end)

  it("draws a box border", function()
    local w = Window:new{ left = 0, top = 0, width = 4, height = 4, color = {0,1,0,1}}
    Window.font.draw = spy.new(function() end)
    w:draw()
    assert.spy(Window.font.draw).was.called_with(Window.font, w.symbols.topleft, 0, 0, {0, 1, 0, 1})
    assert.spy(Window.font.draw).was.called_with(Window.font, w.symbols.topright, 4, 0, {0, 1, 0, 1})
    assert.spy(Window.font.draw).was.called_with(Window.font, w.symbols.bottomleft, 0, 4, {0, 1, 0, 1})
    assert.spy(Window.font.draw).was.called_with(Window.font, w.symbols.bottomright, 4, 4, {0, 1, 0, 1})
    assert.spy(Window.font.draw).was.called_with(Window.font, w.symbols.horizontal, 1, 0, {0, 1, 0, 1})
    assert.spy(Window.font.draw).was.called_with(Window.font, w.symbols.horizontal, 2, 0, {0, 1, 0, 1})
    assert.spy(Window.font.draw).was.called_with(Window.font, w.symbols.horizontal, 3, 0, {0, 1, 0, 1})
    assert.spy(Window.font.draw).was.called_with(Window.font, w.symbols.horizontal, 1, 4, {0, 1, 0, 1})
    assert.spy(Window.font.draw).was.called_with(Window.font, w.symbols.horizontal, 2, 4, {0, 1, 0, 1})
    assert.spy(Window.font.draw).was.called_with(Window.font, w.symbols.horizontal, 3, 4, {0, 1, 0, 1})
    assert.spy(Window.font.draw).was.called_with(Window.font, w.symbols.vertical, 0, 1, {0, 1, 0, 1})
    assert.spy(Window.font.draw).was.called_with(Window.font, w.symbols.vertical, 0, 2, {0, 1, 0, 1})
    assert.spy(Window.font.draw).was.called_with(Window.font, w.symbols.vertical, 0, 3, {0, 1, 0, 1})
    assert.spy(Window.font.draw).was.called_with(Window.font, w.symbols.vertical, 4, 1, {0, 1, 0, 1})
    assert.spy(Window.font.draw).was.called_with(Window.font, w.symbols.vertical, 4, 2, {0, 1, 0, 1})
    assert.spy(Window.font.draw).was.called_with(Window.font, w.symbols.vertical, 4, 3, {0, 1, 0, 1})
  end)

  it("draws a background rectangle in the color specified", function()
    local rect = spy.new(function() end)
    local w = Window:new({ left = 1, top = 1, width = 3, height = 3})
    w.background_color = {0, 0, 1, 1}
    mock_love.override_graphics("rectangle", rect)
    w:draw()
    assert.spy(rect).was.called()
    assert.spy(rect).was.called_with("fill", 0, 0, 30, 33)
  end)

  describe("interior drawing area", function()
    local interior_spy = spy.new(function() end)
    local w = Window:new{
      left = 1,
      top = 1,
      width = 3,
      height = 3,
      color = {1, 1, 1, 1},
      draw_interior = interior_spy
    }

    it("calls to draw the interior if a function is configured for that", function()
      w:draw()
      assert.spy(interior_spy).was.called_with(w)
    end)

    it("sets the translation for the interior to the top left of the interior", function()
      mock_love.override_graphics("push", spy.new(function() end))
      mock_love.override_graphics("translate", spy.new(function() end))
      mock_love.override_graphics("pop", spy.new(function() end))
      w:draw()
      local left = 1 * w.font.width
      local top = 1 * w.font.height
      assert.spy(love.graphics.push).was.called()
      assert.spy(love.graphics.translate).was.called_with(left, top)
      assert.spy(love.graphics.pop).was.called()
    end)
  end)
end)
