-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local tiny = require "ext.tiny-ecs"
local perform_actions = tiny.processingSystem()
perform_actions.filter = tiny.requireAll("is_worker")

function perform_actions:process(e, dt)
  if e.current_task and not e.current_action then
    e.current_action = e.current_task:next_action()
  end

  if e.current_action then
    e.current_action:execute(dt)
    if e.current_action.done then
      e.current_action = nil
    end
  end
end

return perform_actions
