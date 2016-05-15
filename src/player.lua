local util = require 'util'

local Player = util.Node:new{}

function Player:update(node)
  node.position2d = self.window:mouse_position()
end

function Player:_create_node()
  local translate = am.translate(0, 0) ^ am.rect(-50, -50, 50, 50)
  local node = am.wrap(translate)

  function node:get_position2d()
    return translate.position2d
  end

  function node:set_position2d(vec)
    translate.position2d = vec
  end

  return node
end

return Player
