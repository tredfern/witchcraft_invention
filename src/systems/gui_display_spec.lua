-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("GuiDisplaySystem", function()
  local tiny = require "ext.tiny-ecs"
  local GuiDisplay = require "systems.gui_display"
  local mock_love = require "test_helpers.mock_love"

  it("is a draw system", function()
    assert.is_true(GuiDisplay.is_draw_system)
  end)

  it("resets the translation system so that cameras are not impacting the display", function()
    mock_love.override_graphics("origin", spy.new(function() end))
    GuiDisplay:preProcess()
    assert.spy(love.graphics.origin).was.called()
  end)

  it("grabs any entity labeled ui_display to render and draws it", function()
    local world = tiny.world()
    world:addSystem(GuiDisplay)
    local gui = { ui_display = true, draw = spy.new(function() end) }
    world:addEntity(gui)

    world:refresh()
    world:update()
    assert.spy(gui.draw).was.called_with(gui)
  end)
end)
