Spine      = @Spine or require('spine')
Controller = require('framework/core').Controller
$          = Spine.$

class Navigation extends Controller
  className: 'nav navbar-nav'
  tag: 'ul'

  constructor: ->
    super
    @items = []

  addItem: (item) =>
    item.bind 'activated', => @trigger 'activated', @
    item.bind 'activated', @itemActivated
    @bind 'deactivated', item.deactivate
    @items.push item

  deactivate: => @trigger 'deactivated', @

  itemActivated: (activated) =>
    for item in @items
      item.deactivate() unless item is activated

  render: =>
    @el.empty()
    @append(item.render()) for item in @items

class NavItem extends Controller
  tag: 'li'

  activate: =>
    unless @isActive()
      @el.addClass 'active'
      @trigger 'activated', @

  deactivate: =>
    if @isActive()
      @el.removeClass 'active'
      @trigger 'deactivated', @

  isActive: => @el.hasClass 'active'

class Link extends NavItem
  events:
    'click > a' : 'clicked'

  constructor: ->
    super
    throw new Error('@link is required') unless @link
    throw new Error('@text is required') unless @text
    @external = false unless @external
    @router = Spine.Route.create()
    @router.add new RegExp("^#{@link}(\\/[^\\/])*$"), @activate

  clicked: (event) => @trigger 'clicked', @

  render: =>
    if @external
      @html $("<a href='#{@link}'>#{@text}</a>")
    else @html $("<a href='/##{@link}'>#{@text}</a>")

module?.exports      = Navigation
module?.exports.Item = NavItem
module?.exports.Link = Link
