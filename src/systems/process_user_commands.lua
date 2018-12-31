-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tiny = require "ext.tiny-ecs"
local find_entities = require "entities.find_entity_helper"
local ProcessUserCommands = tiny.system()
ProcessUserCommands.filter = tiny.requireAny("is_cursor")

local key_states = {}

function ProcessUserCommands:keypressed(key)
  return love.keyboard.isDown(key)
end

function ProcessUserCommands:keyreleased(key)
  local old = key_states[key] or false
  key_states[key] = love.keyboard.isDown(key)
  return old and not key_states[key]
end

function ProcessUserCommands:update()
  self.cursor = self.cursor or find_entities:by_name(self.entities, "input-cursor"):first()
  if not self.cursor then
    print("most inputs will fail without a cursor")
  end

  if self:keyreleased("c") then
    self:dochopwood() --switch to command pattern later
  end
  self.world:refresh()
end

function ProcessUserCommands:dochopwood()
  local in_position = find_entities:by_position(
    self.world.entities,
    self.cursor.position.x,
    self.cursor.position.y)

  for _, v in ipairs(in_position) do
    if v.is_tree then
      local chopwood_task = require "tasks.chopwood":new(v)
      self.world:add(chopwood_task)
    end
  end
end



return ProcessUserCommands
