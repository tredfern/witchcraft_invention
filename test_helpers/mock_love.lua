local font = {
  getWidth = function() return 10 end,
  getHeight = function() return 10 end
}
local key_down = {}
love = {
    graphics = {
        getWidth = function() return 1600 end,
        getHeight = function() return 900 end,
        newFont = function() return font end,
        origin = function() end,
        pop = function() end,
        print = function() end,
        push = function() end,
        rectangle = function(mode, x, y, w, h) end,
        setColor = function() end,
        setFont = function() end,
        setScissor = function() end,
        translate = function() end,
        newQuad = function() return { } end,
        newImage = function() return {} end
    },
    filesystem = {
        read = function(path)
            local file = io.open(path, "rb") -- r read mode and b binary mode
            if not file then return nil end
            local content = file:read "*a" -- *a or *all reads the whole file
            file:close()
            return content
        end
    },
    keyboard = {
      isDown = function(key)
        return key_down[key] ~= nil
      end
    },
    timer = {
      getDelta = function() return 0.03 end
    },
    handlers = { }
}
return {
  override_graphics = function(v, r)
    love.graphics[v] = r
  end,
  simulate_key_down = function(key)
    key_down[key] = true
  end,
  simulate_key_up = function(key)
    key_down[key] = nil
  end
}
