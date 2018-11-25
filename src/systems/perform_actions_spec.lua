-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("Systems - perform_actions", function()
  require "test_helpers.mock_love"
  local systems = require "systems"
  local tiny = require "ext.tiny-ecs"
  local world = tiny.world()

  before_each(function()
    world:clearEntities()
    world:clearSystems()
    world:refresh()
    world:addSystem(systems.perform_actions)
    world:refresh()
  end)

  it("when an entity has no action, it takes the next action, assigns it to current and then executes it", function()
    local action = { execute = spy.new(function() end) }
    local task = { next_action = spy.new(function() return action end) }
    local e = { is_worker = true, current_task = task }
    world:addEntity(e)
    world:refresh()
    systems.perform_actions:update(0.02)
    assert.spy(task.next_action).was.called()
    assert.spy(action.execute).was.called_with(action, 0.02)
    assert.equals(action, e.current_action)
  end)

  it("performs the current action and ignores the queue if a current action is assigned", function()
    local action = { execute = spy.new(function() end) }
    local action2 = { execute = spy.new(function() end) }
    local task = { next_action = function() return action2 end }
    local e = { is_worker = true, current_task = task }
    e.current_action = action
    world:addEntity(e)
    world:refresh()
    systems.perform_actions:update(0.02)
    assert.spy(action.execute).was.called_with(action, 0.02)
    assert.spy(action2.execute).was.not_called()
  end)

  it("assigns the current action to nil if the action is flagged as done", function()
    local action = { execute = spy.new(function() end), done = true }
    local task = { next_action = function() return action end }
    local e = { is_worker = true, current_task = task }
    world:addEntity(e)
    world:refresh()
    systems.perform_actions:update(0.02)
    assert.equals(nil, e.current_action)
  end)

  it("if no current_task then just do nothing with entity", function()
    local e = { is_worker = true }
    world:addEntity(e)
    world:refresh()
    systems.perform_actions:update(0.02)
    assert.equals(nil, e.current_action)
  end)
end)
