-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Scenes - Title", function()
  local Scene = require "scenes.scene"
  local Title = require "scenes.title"
  local NewGame = require "scenes.new_game"

  it("can switch to a new game scene", function()
    local t = Title:new()
    t:new_game()
    assert.is_true(Scene.current_scene:isInstanceOf(NewGame))
  end)
end)
