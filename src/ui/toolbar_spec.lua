-- Copyright (c) 2019 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Toolbar", function()
  local Toolbar = require "ui.toolbar"
  local Button = require "ui.button"

  describe("adding buttons to the toolbar", function()
    local tb = Toolbar:new()
    tb:add(Button:new("Chop Wood", function() end))
    tb:add(Button:new("Haul", function() end))

    it("tracks the buttons added", function()
      assert.equals(2, #tb.buttons)
    end)
  end)

  describe("rendering", function()
    it("is rendered by the GuiDisplay System", function()
      -- Create a system and world
      local GuiDisplay = require "systems.gui_display"
      local world = require "ext.tiny-ecs".world()
      world:addSystem(GuiDisplay)

      -- Add in the toolbar
      local tb = Toolbar:new()
      tb.draw = spy.new(function() end)
      world:addEntity(tb)

      --Test
      world:update()

      assert.spy(tb.draw).was.called()
    end)
  end)
end)
