Spine      = @Spine or require('spine')
Controller = require('framework/core').Controller
$          = Spine.$

class Breadcrumb extends Controller
  className: 'breadcrumb'
  tag: 'ol'

  constructor: ->
    super
    @items = []

  addItem: (item)    => @items.push item
  removeItem: (item) => _.remove(@items, (i) -> i is item)

  render: =>
    @el.empty()
    $.each @items, (i, item) => @append item.render()
    @el

class Item extends Controller
  tag: 'li'

  constructor: ->
    super
    throw new Error('@link is required') unless @link
    throw new Error('@regex is required') unless @regex
    throw new Error('@text is required') unless @text
    @router = Spine.Route.create()
    @router.add new RegExp(@regex), @activate

  activate: =>
    unless @isActive()
      @parent.activate() if @parent
      @el.show()
      @trigger 'activated', @
      @trigger 'toggled', @

  deactivate: =>
    if @isActive()
      @el.hide()
      @trigger 'deactivated', @
      @trigger 'toggled', @

  isActive: => @el.is(':visible')
  render:   => @html $("<a href='#{@link}'>#{@text}</a>")

  toggle: =>
    if @isActive()
      @deactivate()
    else @activate()

module?.exports      = Breadcrumb
module?.exports.Item = Item
