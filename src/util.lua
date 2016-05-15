local util = ...

util.Class = {}

function util.Class:new(o)
  o = o or {}

  setmetatable(o, self)
  self.__index = self

  return o
end

util.Node = util.Class:new{}

function util.Node:create(o)
  o = self:new(o)

  if o.node == nil then
    o.node = self:_create_node()
  end

  return o
end

function util.Node:get_node()
  return self.node
end

function util.Node:_create_node()
  return am.group{}
end
