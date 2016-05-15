local utils = require 'utils'

local blur_vert = [[
  precision highp float;

  attribute vec2 uv;
  attribute vec2 vert;

  uniform mat4 MV;
  uniform mat4 P;

  varying vec2 v_uv;

  void main() {
    v_uv = uv;
    gl_Position = P * MV * vec4(vert, 0.0, 1.0);
  }
]]

local blur_frag = [[
  precision highp float;

  uniform sampler2D last_tex;
  uniform sampler2D tex;
  uniform float blur;

  varying vec2 v_uv;

  void main() {
    vec4 last_colour = texture2D(last_tex, v_uv) * blur;

    if (last_colour.r < 0.015) {
      last_colour.r = 0.0;
    }

    if (last_colour.g < 0.015) {
      last_colour.g = 0.0;
    }

    if (last_colour.b < 0.015) {
      last_colour.b = 0.0;
    }

    if (last_colour.a < 0.015) {
      last_colour.a = 0.0;
    }

    vec4 colour = texture2D(tex, v_uv);

    gl_FragColor = last_colour + colour;
  }
]]

local Blur = utils.Node:new{}

function Blur:_create_node()
  local last_tex = am.texture2d(self.window.pixel_width, self.window.pixel_height)
  local last_fb = am.framebuffer(last_tex)

  last_fb.projection = self.window.projection

  last_fb:clear()

  local tex = am.texture2d(self.window.pixel_width, self.window.pixel_height)
  local fb = am.framebuffer(tex)

  fb.projection = self.window.projection

  fb:clear()

  local program = am.program(blur_vert, blur_frag)
  local postprocess =
    am.use_program(program)
    ^ am.bind{
        P = mat4(1),
        uv = am.rect_verts_2d(0, 0, 1, 1),
        vert = am.rect_verts_2d(-1, -1, 1, 1),
        last_tex = last_tex,
        tex = tex,
        blur = self.blur or 0.5
    }
    ^ am.draw("triangles", am.rect_indices())
  local node = am.wrap(postprocess)

  node:action(function()
    if self.window:resized() then
      last_fb:resize(self.window.pixel_width, self.window.pixel_height)
      fb:resize(self.window.pixel_width, self.window.pixel_height)
    end

    last_fb.projection = self.window.projection
    fb.projection = self.window.projection

    last_fb:render(node)

    fb:clear()
    fb:render_children(node)
  end)

  return node
end

table.merge(..., {
  Blur = Blur,
})
