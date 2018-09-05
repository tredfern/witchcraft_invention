local font = {
}
love = {
    graphics = {
        getWidth = function() return 1600 end,
        getHeight = function() return 900 end,
        rectangle = function(mode, x, y, w, h) end,
        setColor = function() end,
        setScissor = function() end,
        newFont = function() return font end
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
    handlers = { }
}