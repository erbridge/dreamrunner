local Player = require 'player'

local function setup_scene()
  local window = am.window{
    title = "DREAMRUNNER",
  }

  window.scene = am.group{}

  return window
end

local function start_game()
  local window = setup_scene()
  local player = Player:create{}

  window.scene:append(player:get_node())
end

start_game()
