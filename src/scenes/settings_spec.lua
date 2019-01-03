-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Scenes - Settings", function()
  local Scene = require "scenes.scene"
  local Settings = require "scenes.settings"
  local Title = require "scenes.title"

  it("can go back to the title screen on escape key", function()
    local s = Settings:new()
    s:keypressed("escape")
    assert.is_true(Scene.current_scene:isInstanceOf(Title))
  end)
end)
