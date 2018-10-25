-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local mocklove = require "test_helpers/mock_love"

describe("TextTiles", function()
  local TextTiles = require "text_tiles"

  it("Loads a font and has a global tile size", function()
    local f = { getWidth = function() return 10 end, getHeight = function() return 11 end }
    mocklove.override_graphics("newFont", spy.new(function() return f end))
    local t = TextTiles:new("FreeMono.ttf", 10)
    assert.equals(10, t.size)
    assert.equals(f, t.font)
    assert.equals(10, t.width)
    assert.equals(11, t.height)
  end)
end)
