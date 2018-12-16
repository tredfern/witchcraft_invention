-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("SpriteSheet", function()
  local SpriteSheet = require "spritesheet"
  local mock_love = require "test_helpers.mock_love"

  local testSheet

  before_each(function()
    local dumbImage = {
      getHeight = function() return 1000 end,
      getWidth = function() return 1000 end
    }
    mock_love.override_graphics("newImage", function() return dumbImage end)

    testSheet = SpriteSheet:new{
      name = "basesheet.png",
      width = 16,
      height = 16,
      margin = 1
    }
  end)

  it("can slice the spritesheet based on tile width, height and margin", function()
    assert.equals(math.floor(1000 / 17), testSheet.tiles_wide)
    assert.equals(85, testSheet:getTileX(5))
    assert.equals(68, testSheet:getTileY(4))
  end)

  it("can make a quad based on the specified coordinates", function()
    local quad = {}
    local spyQuad = spy.new(function() return quad end)
    mock_love.override_graphics("newQuad", spyQuad)
    local q = testSheet:getQuad(5, 4)
    assert.equal(quad, q)
    assert.spy(spyQuad).was.called_with(85, 68, 16, 16, 1000, 1000)
  end)

  it("returns the same quad each time without regenerating a new quad for the same coordinates", function()
    local spyQuad = spy.new(function() return {} end)
    mock_love.override_graphics("newQuad", spyQuad)
    local q = testSheet:getQuad(5, 4)
    local q2 = testSheet:getQuad(5, 4)
    assert.equals(q, q2)
  end)

  it("can name coordinates a specific entry to quickly access that coordinate", function()
    testSheet:setName("water", 5, 4)
    assert.not_equal(nil, testSheet.water)
    assert.equals(testSheet:getQuad(5, 4), testSheet.water)
  end)
end)
