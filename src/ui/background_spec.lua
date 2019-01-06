-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Background", function()
  local Background = require "ui.background"
  local mock_love = require "test_helpers.mock_love"

  it("has an image to render", function()
    local b = Background:new("images/title_background.png")
    assert.not_nil(b.image)
  end)

  it("draws centering the image into the screen", function()
    mock_love.mock(love.graphics, "draw", spy.new(function() end))
    local b = Background:new("images/title_background.png")
    local target_x = (love.graphics.getWidth() - b.image.getWidth()) / 2
    local target_y = (love.graphics.getHeight() - b.image.getHeight()) / 2
    b:draw()
    assert.spy(love.graphics.draw).was.called_with(b.image, target_x, target_y)
  end)
end)
