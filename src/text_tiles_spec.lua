-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local mocklove = require "test_helpers/mock_love"

describe("TextTiles", function()
  local font = { getWidth = function() return 10 end, getHeight = function() return 11 end }
  mocklove.override_graphics("newFont", spy.new(function() return font end))

  local TextTiles = require "text_tiles"

  it("Loads a font and has a global tile size", function()
    local t = TextTiles:new("FreeMono.ttf", 10)
    assert.equals(10, t.size)
    assert.equals(font, t.font)
    assert.equals(10, t.width)
    assert.equals(11, t.height)
  end)

  it("can get screen coordinates for tile", function()
    local t = TextTiles:new("font", 10)
    local left, top, right, bottom = t:get_box(1, 1)
    assert.equals(0, left)
    assert.equals(0, top)
    assert.equals(t.width, right)
    assert.equals(t.height, bottom)
  end)

  it("can be drawn to a specific screen location", function()
    mocklove.override_graphics("setFont", spy.new(function() end))
    mocklove.override_graphics("setColor", spy.new(function() end))
    mocklove.override_graphics("print", spy.new(function() end))
    local t = TextTiles:new("FreeMono.ttf", 10)
    local character = "A"
    local x = 3
    local y = 2
    local color = {1, 1, 1, 1}
    t:draw(character, x, y, color)
    assert.spy(love.graphics.setFont).was.called_with(t.font)
    assert.spy(love.graphics.setColor).was.called_with(color)
    assert.spy(love.graphics.print).was.called_with(character, (x - 1) * t.width, (y - 1) * t.height)
  end)

  it("can return a table that can be rendered and modified easily", function()
    local t = TextTiles:new("font", 10)
    local img = t:new_tile("A", 1, 1, {1, 1, 1, 1})
    t.draw = spy.new(function() end)
    img:draw()
    assert.spy(t.draw).was_called()
    assert.spy(t.draw).was.called_with(t, img.symbol, img.x, img.y, img.color)
  end)

  it("can calculate the screen size in tiles", function()
    local t = TextTiles:new("font", 10)
    local sw, sh = t:get_screen_tile_size()
    assert.equals(love.graphics.getWidth() / t.width, sw)
    assert.equals(love.graphics.getHeight() / t.height, sh)
  end)

  it("returns the previously loaded font instead of loading more", function()
    local t = TextTiles:new("font", 10)
    local t2 = TextTiles:new("font", 10)
    assert.equals(t, t2)
  end)

  it("can have one sent as default for general usage", function()
    local t = TextTiles:new("font", 10)
    t:make_default()
    assert.equals(t, TextTiles.default)
  end)

end)
