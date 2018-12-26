-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

return {
  assign_tasks = require "systems.assign_tasks",
  entity_factory = require "systems.entity_factory",
  entity_tracker = require "systems.entity_tracker",
  gather_resources = require "systems.gather_resources",
  gui_display = require "systems.gui_display",
  perform_actions = require "systems.perform_actions",
  process_user_commands = require "systems.process_user_commands",
  render_map = require "systems.render_map",
  render_symbols = require "systems.render_symbol_system",
}
