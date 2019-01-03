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

  it("deactivates an old scene if one is active when activating a new one", function()
    local a = Scene:new()
    local b = Scene:new()
    a.deactivate = spy.new(function() end)
    a:activate()
    b:activate()
    assert.spy(a.deactivate).was.called()
  end)

  it("has methods that support love functions for the scene", function()
    local a = Scene:new()
    assert.has_no.errors(function()
      a:draw()
      a:update()
      a:keypressed()
    end)
  end)
end)
