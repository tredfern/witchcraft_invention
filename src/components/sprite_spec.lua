-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Sprite", function()
  local Sprite = require "components.sprite"
  local SpriteSheet = require "graphics.spritesheet"
  local mock_love = require "test_helpers.mock_love"

  it("can be drawn to the screen at a specified location", function()
    mock_love.override_graphics("draw", spy.new(function() end))
    local s = Sprite:new{ image = "foo" }
    s:draw(30, 21)
    assert.spy(love.graphics.draw).was.called_with("foo", 30, 21)
  end)

  it("uses a spritesheet to represent many images and renders a quad", function()
    local sheet = mock(SpriteSheet:new{ name = "sheet", width = 10, height = 10, margin = 0 })
    local q = sheet:getQuad(2, 3)
    mock_love.override_graphics("draw", spy.new(function() end))
    local s = Sprite:new{ sheet = sheet, tx = 2, ty = 3 }
    s:draw(32, 43)
    assert.spy(love.graphics.draw).was.called()
    assert.spy(love.graphics.draw).was.called_with(sheet.image, q, 32, 43)
  end)
end)
