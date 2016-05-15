local util = require 'util'

local Player = util.Node:new{}

function Player:_create_node()
  return am.rect(-50, -50, 50, 50)
end

return Player
