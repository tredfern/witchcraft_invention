-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Scenes - Title", function()
  local mock_love = require "test_helpers.mock_love"
  local Scene = require "scenes.scene"
  local Title = require "scenes.title"
  local NewGame = require "scenes.new_game"
  local LoadGame = require "scenes.load_game"
  local Settings = require "scenes.settings"

  it("can switch to a new game scene", function()
    local t = Title:new()
    t:keypressed("n")
    assert.is_true(Scene.current_scene:isInstanceOf(NewGame))
  end)

  it("can switch to a load screen", function()
    local t = Title:new()
    t:keypressed("l")
    assert.is_true(Scene.current_scene:isInstanceOf(LoadGame))
  end)

  it("can switch to a settings screen", function()
    local t = Title:new()
    t:keypressed("s")
    assert.is_true(Scene.current_scene:isInstanceOf(Settings))
  end)

  it("can quit the game", function()
    mock_love.mock(love.event, "quit", spy.new(function() end))
    local t = Title:new()
    t:keypressed("q")
    assert.spy(love.event.quit).was.called()
  end)
end)
