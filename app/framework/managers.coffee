Spine = @Spine or require('spine')

class Stack extends Spine.Stack
  @controllers = []

  constructor: ->
    super

    for name, cont of @manager.controllers
      for stack_cont of Stack.controllers
        if cont.el.find stack_cont.el
          stack_cont.active cont.active

    Stack.controllers = Array.prototype.push.apply(Stack.controllers, @manager.controllers)

module?.exports       = {}
module?.exports.Stack = Stack
