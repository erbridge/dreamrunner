local util = require 'util'

local Player = util.Node:new{}

function Player:update(node)
  local node_pos = node.position2d
  local mouse_pos = self.window:mouse_position()

  -- TODO: Make the springs asymmetrical, so they match the aspect ratio.
  local action_force = (mouse_pos - node_pos)
  local reset_force = node_pos / 2
  local total_force = action_force - reset_force

  node.position2d = node_pos + total_force * am.delta_time
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
