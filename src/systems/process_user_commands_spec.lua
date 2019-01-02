-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("ProcessUserCommands", function()
  local mock_love = require "test_helpers.mock_love"
  local tiny = require "ext.tiny-ecs"
  local world = tiny.world()
  local Taskboard = require "tasks.taskboard"
  local ProcessUserCommands = require "systems.process_user_commands"

  before_each(function()
    world:clearEntities()
    world:clearSystems()
    world:refresh()
    world:addSystem(ProcessUserCommands)
    world:refresh()
    Taskboard:clear()
  end)

  it("is an update only system", function()
    assert.is_falsy(ProcessUserCommands.is_drawing_system)
  end)

  it("if c is pressed and the cursor is over a tree, it will flag that tree for chopping", function()
    local tree = require "entities.tree":new(24, 21)
    local cursor = require "entities.cursor":new(24, 21)
    world:add(tree, cursor)
    world:refresh()

    --key press with cursor at 24, 21
    mock_love.simulate_key_down("c")
    ProcessUserCommands:update()
    mock_love.simulate_key_up("c")
    ProcessUserCommands:update()
    local nextTask = Taskboard:next()
    assert.equals(tree, nextTask.target)
  end)

  it("if a key is held down keypressed will be true", function()
    mock_love.simulate_key_down("c")
    --key press with cursor at 24, 21
    assert.is_true(ProcessUserCommands:keypressed("c"))
  end)

  it("if a key had been pressed and then released between updates, keyreleased should return true", function()
    mock_love.simulate_key_down("c")
    --key press with cursor at 24, 21
    assert.is_false(ProcessUserCommands:keyreleased("c"))
    assert.is_false(ProcessUserCommands:keyreleased("c"))
    assert.is_false(ProcessUserCommands:keyreleased("c"))
    assert.is_false(ProcessUserCommands:keyreleased("c"))

    mock_love.simulate_key_up("c")
    assert.is_true(ProcessUserCommands:keyreleased("c"))
  end)
end)
