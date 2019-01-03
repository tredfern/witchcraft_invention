-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Scenes - New Game", function()
  local Scene = require "scenes.scene"
  local NewGame = require "scenes.new_game"
  local Game = require "scenes.game"
  local Title = require "scenes.title"

  it("can create a new game", function()
    local n = NewGame:new()
    n:keypressed("space")
    assert.is_true(Scene.current_scene:isInstanceOf(Game))
  end)

  it("can return to the title screen", function()
    local n = NewGame:new()
    n:keypressed("escape")
    assert.is_true(Scene.current_scene:isInstanceOf(Title))
  end)
end)
