-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Game", function()
  require "test_helpers.mock_love"
  local game = require "scenes.game"

  it("configures systems to be used for rendering", function()
    assert.array_includes(require("systems.render_map"), game.world.systems)
    assert.array_includes(require("systems.render_symbol_system"), game.world.systems)
  end)

  it("draws only systems that have the render_system flag set", function()
    local rm = require("systems.render_map")
    local rs = require("systems.render_symbol_system")
    rm.update = spy.new(function() end)
    rs.update = spy.new(function() end)
    game:draw()
    assert.spy(rm.update).was.called()
    assert.spy(rs.update).was.called()
  end)

  it("updates only systems that do not have the render_system flag set", function()
  end)
end)
