-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Window", function()
  local mock_love = require "test_helpers.mock_love"
  local Window = require "src.ui.window"

  describe("drawing window", function()
    local w = Window:new{ left = 0, top = 0, width = 100, height = 150, color = {0,1,0,1}}
    it("draws a box border", function()
      mock_love.mock(love.graphics, "setColor", spy.new(function() end))
      mock_love.mock(love.graphics, "rectangle", spy.new(function() end))
      w:draw()
      assert.spy(love.graphics.setColor).was.called_with(w.color)
      assert.spy(love.graphics.rectangle).was.called_with("line", 0, 0, 100, 150)
    end)

    it("draws a background rectangle in the color specified", function()
      mock_love.mock(love.graphics, "setColor", spy.new(function() end))
      mock_love.mock(love.graphics, "rectangle", spy.new(function() end))
      w.background_color = {0, 0, 1, 1}
      w:draw()
      assert.spy(love.graphics.setColor).was.called_with(w.background_color)
      assert.spy(love.graphics.rectangle).was.called_with("fill", 0, 0, 100, 150)
    end)
  end)

  describe("interior drawing area", function()
    local interior_spy = spy.new(function() end)
    local w = Window:new{
      left = 0,
      top = 0,
      width = 300,
      height = 35,
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
      assert.spy(love.graphics.push).was.called()
      assert.spy(love.graphics.translate).was.called_with(w.left, w.top)
      assert.spy(love.graphics.pop).was.called()
    end)

    it("sets a scissors for the draw area to clip the draw to within the area", function()
      mock_love.override_graphics("setScissor", spy.new(function() end))
      w:draw()
      assert.spy(love.graphics.setScissor).was.called_with(w.left, w.top, w.width, w.height)
      assert.spy(love.graphics.setScissor).was.called_with()
    end)
  end)

  describe("anchor functions", function()
    mock_love.mock(love.graphics, "getWidth", function() return 1600 end)
    mock_love.mock(love.graphics, "getHeight", function() return 900 end)

    it("can be anchored to the right side of the screen", function()
      local w = Window:new({width = 500})
      w:anchor_right()
      assert.equals(1100, w.left)
    end)

    it("can be anchored to the bottom of the screen", function()
      local w = Window:new({height = 100})
      w:anchor_bottom()
      assert.equals(800, w.top)
    end)

    it("can be anchored to the left o f the screen", function()
      local w = Window:new({left = 200})
      assert.equals(200, w.left)
      w:anchor_left()
      assert.equals(0, w.left)
    end)

    it("can be anchored to the top of the screen", function()
      local w = Window:new({top = 300})
      assert.equals(300, w.top)
      w:anchor_top()
      assert.equals(0, w.top)
    end)
  end)
end)
