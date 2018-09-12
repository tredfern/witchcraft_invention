-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("State Machine", function()
  local StateMachine = require("statemachine")
  it("can be set up as a new state machine instance", function()
    local sm = StateMachine:new()
    assert.not_equal(nil, sm)
  end)

  it("registers whatever methods are provided to constructor", function()
    local sm = StateMachine:new{"update", "draw", "fly"}
    assert.not_equal(nil, sm.update)
    assert.not_equal(nil, sm.draw)
    assert.not_equal(nil, sm.fly)
  end)

  it("returns nil if methods are called with no current state", function()
    local sm = StateMachine:new{"hello"}
    assert.equal(nil, sm:hello())
  end)

  it("returns nil if the current state does not implement the method", function()
    local sm = StateMachine:new{"hello"}
    sm:change({})
    assert.equal(nil, sm:hello())
  end)

  it("returns the value of the current state", function()
    local sm = StateMachine:new{"hello"}
    sm:change({ hello = function() return "Hi!" end })
    assert.equal("Hi!", sm:hello())
  end)

  it("passes the current state into a state method", function()
    local sm = StateMachine:new{"hello"}
    local state = {
      name = "infancy",
      hello = function(self) return self.name end
    }
    sm:change(state)
    assert.equal("infancy", sm:hello())
  end)

  it("different state machines have different methods", function()
    local scene = StateMachine:new{"show"}
    local character = StateMachine:new{"talk"}
    assert.equal(nil, scene.talk)
    assert.equal(nil, character.show)
    assert.not_equal(nil, scene.show)
    assert.not_equal(nil, character.talk)
  end)

  it("passes any args passed into the state method", function()
    local scene = StateMachine:new{"show"}
    local menu = { show = function(self, var1, var2) return var1, var2, self end }
    scene:change(menu)
    local r1, r2 = scene:show("value 1", "value 2")
    assert.equal("value 1", r1)
    assert.equal("value 2", r2)
  end)

  it("can be set up to have different functions for different scenes that are called to the active state", function()
    local scenes = StateMachine:new({"update"})
    local menu = {}
    menu.update = function() return "menu update" end
    local game = {}
    game.update = function() return "game update" end

    scenes:change(menu)
    assert.equal("menu update", scenes:update())

    scenes:change(game)
    assert.equal("game update", scenes:update())
  end)
end)
