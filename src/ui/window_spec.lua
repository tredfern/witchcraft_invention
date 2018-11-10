-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT
local mocklove = require "test_helpers/mock_love"
local utf8 = require "utf8"

describe("Window", function()
  local Window = require "src.ui.window"
  it("has box drawing elements defined", function()
    assert.equals(utf8.char(0x250C), Window.symbols.topleft)
    assert.equals(utf8.char(0x2510), Window.symbols.topright)
    assert.equals(utf8.char(0x2514), Window.symbols.bottomleft)
    assert.equals(utf8.char(0x2518), Window.symbols.bottomright)
    assert.equals(utf8.char(0x2500), Window.symbols.horizontal)
    assert.equals(utf8.char(0x2502), Window.symbols.vertical)
  end)

  it("has coordinates based on tile coordinates", function()
    local w = Window:new(10, 10, 20, 20)
    assert.equals(10, w.x)
    assert.equals(10, w.y)
    assert.equals(20, w.width)
    assert.equals(20, w.height)
  end)

  it("draws a box border", function()
    local w = Window:new(0, 0, 4, 4, {0,1,0,1})
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
    local w = Window:new(1, 1, 3, 3, {1,1,1,1})
    w.background_color = {0, 0, 1, 1}
    mocklove.override_graphics("rectangle", rect)
    w:draw()
    assert.spy(rect).was.called_with("fill", 0, 0, 30, 30)
  end)
end)
