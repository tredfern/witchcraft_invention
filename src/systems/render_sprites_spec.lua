-- Copyright (c) 2018 Redfern, Trevor <trevorredfern@gmail.com>
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("RenderSprites", function()
  local settings = require "settings"
  local components = require "components"
  local tiny = require "ext.tiny-ecs"
  local world = tiny.world()
  local RenderSprites = require "systems.render_sprites"
  world:addSystem(RenderSprites)

  before_each(function()
    world:clearEntities()
    world:refresh()
  end)

  it("is a drawing system", function()
    assert.is_true(RenderSprites.is_draw_system)
  end)

  it("draws the sprite in the tile location", function()
    local entityWithSprite = {
      position = components.position:new(5, 8),
      sprite = {}
    }
    entityWithSprite.sprite.draw = spy.new(function() end)
    world:addEntity(entityWithSprite)
    world:refresh()
    world:update()

    assert.spy(entityWithSprite.sprite.draw).was.called_with(
      entityWithSprite.sprite,
      5 * settings.tile_width,
      8 * settings.tile_height)
  end)

end)
