local effects = require 'effects'
local Player = require 'player'

local function setup_scene()
  local window = am.window{
    title = 'DREAMRUNNER',
    mode = 'fullscreen',
    width = 1920,
    height = 1080,
  }

  local blur = effects.Blur:create{
    window = window,
    blur = 0.5,
  }

  window.scene = blur:get_node()

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
