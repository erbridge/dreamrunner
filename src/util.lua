Class = {}

function Class:new(o)
  o = o or {}

  setmetatable(o, self)
  self.__index = self

  return o
end

Node = Class:new{}

function Node:create(o)
  o = self:new(o)

  if not o.node then
    o.node = self:_create_node()
  end

  o.node:action(function(node)
    if o.update then
      o:update(node)
    end
  end)

  return o
end

function Node:get_node()
  return self.node
end

function Node:_create_node()
  return am.group{}
end

table.merge(..., {
  Class = Class,
  Node = Node,
})
