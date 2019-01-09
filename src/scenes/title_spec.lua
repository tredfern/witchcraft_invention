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

  it("arrow keys move the focused item", function()
    local t = Title:new()
    t:keypressed("down")
    assert.equals(t.menu.items[2], t.menu:get_focused_item())
    t:keypressed("up")
    assert.equals(t.menu.items[1], t.menu:get_focused_item())
  end)

  it("space key triggers the selected item", function()
    local t = Title:new()
    -- New Game
    t:keypressed("space")
    assert.is_true(Scene.current_scene:isInstanceOf(NewGame))

    -- Load Game
    t:keypressed("down")
    t:keypressed("space")
    assert.is_true(Scene.current_scene:isInstanceOf(LoadGame))

    -- Settings
    t:keypressed("down")
    t:keypressed("space")
    assert.is_true(Scene.current_scene:isInstanceOf(Settings))

    -- Quit Game
    mock_love.mock(love.event, "quit", spy.new(function() end))
    t:keypressed("down")
    t:keypressed("space")
    assert.spy(love.event.quit).was.called()
  end)

  it("enter key works like space key", function()
    local t = Title:new()
    t.menu.click = spy.new(function() end)
    t:keypressed("return")
    assert.spy(t.menu.click).was.called()
  end)
end)
