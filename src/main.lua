local Player = require 'player'

local function setup_scene()
  local window = am.window{
    title = 'DREAMRUNNER',
    mode = 'fullscreen',
    width = 1920,
    height = 1080,
  }

  window.scene = am.group{}

  return window
end

local function start_game()
  local window = setup_scene()
  local player = Player:create{
    window = window,
  }

  window.scene:append(player:get_node())
end

start_game()
