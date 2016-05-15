local util = require 'util'

local Player = util.Node:new{}

function Player:update(node)
  local node_pos = node.position2d
  local mouse_pos = self.window:mouse_position()
  local delta = mouse_pos - node_pos
  local max_delta = self.window.width / 2
  local norm_delta = math.min(math.length(delta), max_delta) / max_delta

  -- TODO: Try a spring equation from the centre instead.
  delta = delta * (1 - math.exp(am.delta_time * norm_delta / -2))

  node.position2d = node_pos + delta
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
