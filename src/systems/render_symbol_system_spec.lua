-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("RenderSymbolSystem", function()
  local mock_love = require "test_helpers.mock_love"

  it("renders an entity using the appropriate text_tile", function()
    local drawCall = spy.new(function() end)
    local RenderSymbolSystem = require "systems.render_symbol_system"
    RenderSymbolSystem.tiles.draw = drawCall

    local e = { position = { x = 10, y = 3 }, symbol = "A", color = {1,1,1,1}}
    mock_love.override_graphics("setColor", spy.new(function() end))
    mock_love.override_graphics("print", spy.new(function() end))

    RenderSymbolSystem:process(e)

    assert.spy(drawCall).was.called_with(RenderSymbolSystem.tiles, e.symbol, e.position.x, e.position.y, e.color)
  end)

  it("filters based on whether an entity has position, symbol, and color attributes", function()
    local RenderSymbolSystem = require "systems.render_symbol_system"
    local tiny = require "ext.tiny-ecs"
    local world = tiny.world()
    local e1 = { position = { x = 10, y = 10 } , symbol = "A", color = {1,1,1,1} }
    local e2 = { position = { x = 11, y = 11 }, symbol = "B" }
    local e3 = { symbol = "F", color = { 1, 1, 1, 1 } }

    -- Should be called each time entity is added to system, but only one should be added

    world:add(RenderSymbolSystem, e1, e2, e3)
    world:refresh()

    assert.equals(1, #RenderSymbolSystem.entities)
    assert.array_includes(e1, RenderSymbolSystem.entities)
  end)
end)
