-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("actions.move_to", function()
  local actions = require "actions"

  it("has a target position to move to", function()
    local owner = { position = {x = 1, y = 3 } }
    local a = actions.move_to:new(owner, {x = 3, y = 4})
    assert.equals(owner, a.owner)
    assert.equals(3, a.target.x)
    assert.equals(4, a.target.y)
  end)

  it("will attempt to move the character based on it's speed to the target location", function()
    local owner = { position = {x = 1, y = 3 }, speed = 0.1 }
    local a = actions.move_to:new(owner, {x = 3, y = 4})
    a:execute(0.1)
    assert.equals(2, owner.position.x)
    assert.equals(4, owner.position.y)
  end)

  it("will attempt to move the character based on it's speed to the target location - opposite direction", function()
    local owner = { position = {x = 3, y = 4 }, speed = 0.1 }
    local a = actions.move_to:new(owner, {x = 1, y = 3})
    a:execute(0.1)
    assert.equals(2, owner.position.x)
    assert.equals(3, owner.position.y)
  end)

  it("will wait until enough time has passed based on character speed to move to the next tile", function()
    local owner = { position = {x = 1, y = 3 }, speed = 0.3 }
    local a = actions.move_to:new(owner, {x = 3, y = 4})
    a:execute(0.1)
    assert.equals(1, owner.position.x)
    assert.equals(3, owner.position.y)
    assert.equals(0.1, a.progress)
    a:execute(0.1)
    assert.equals(1, owner.position.x)
    assert.equals(3, owner.position.y)
    assert.equals(0.2, a.progress)
    a:execute(0.1)
    assert.equals(2, owner.position.x)
    assert.equals(4, owner.position.y)
    assert.equals(0, a.progress)
  end)
end)
