-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Scenes - Load Game", function()
  local LoadGame = require "scenes.load_game"
  local Scene = require "scenes.scene"
  local Title = require "scenes.title"

  it("can go back to the title screen", function()
    local l = LoadGame:new()
    l:keypressed("escape")
    assert.is_true(Scene.current_scene:isInstanceOf(Title))
  end)

end)
