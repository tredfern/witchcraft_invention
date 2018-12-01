-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Stockpile", function()
  local stockpile = require "entities.stockpile"

  it("has a symbol and color to render", function()
    local s = stockpile:new(5, 4, 1, 1)
    assert.equals("#", s.symbol)
    assert.not_equal(nil, s.color)
  end)

  it("covers a range of squares", function()
    local s = stockpile:new(5, 4, 10, 11)
    assert.equals(5, s.position.x)
    assert.equals(4, s.position.y)
    assert.equals(10, s.size.width)
    assert.equals(11, s.size.height)
  end)

  it("provides a component for storage", function()
    local s = stockpile:new(5, 4, 10, 11)
    assert.not_equal(nil, s.storage)
  end)
end)
