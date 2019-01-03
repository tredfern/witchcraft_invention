-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Scene", function()
  local Scene = require "scenes.scene"

  it("when activating scene it sets itself to the current active scene", function()
    local a = Scene:new()
    a:activate()
    assert.equals(a, Scene.current_scene)
  end)
end)
