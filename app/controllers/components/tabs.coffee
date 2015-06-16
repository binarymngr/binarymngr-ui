Spine      = @Spine or require('spine')
Controller = require('framework/core').Controller
Navigation = require('controllers/components/navigation')
$          = Spine.$

class TabNav extends Navigation
  attributes:
    role: 'tablist'
  className: 'nav nav-tabs'

class NavItem extends Navigation.Item
  attributes:
    role: 'presentation'

  events:
    'click > a' : 'activate'

  constructor: ->
    super
    throw new Error('@tab is required') unless @tab
    throw new Error('@text is required') unless @text
    @bind 'activated', @tab.activate
    @bind 'deactivated', @tab.deactivate

  render: => @html $("<a href='##{@tab.name}' aria-controls='#{@tab.name}' \
                     role='tab' data-toggle='tab'>#{@text}</a>")

class TabContainer extends Controller
  className: 'tab-content'

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

class Tab extends Controller
  attributes:
    role: 'tabpanel'
  className: 'tab-pane'

  constructor: ->
    super
    throw new Error('@name is required') unless @name
    @attributes.id = @name
    @el.attr 'id', @name

  activate: =>
    unless @isActive()
      @el.addClass 'active'
      @trigger 'activated', @

  deactivate: =>
    if @isActive()
      @el.removeClass 'active'
      @trigger 'deactivated', @

  isActive: => @el.hasClass 'active'

module?.exports           = {}
# navigation
module?.exports.Nav       = TabNav
module?.exports.Nav.Item  = NavItem
# content
module?.exports.Container = TabContainer
module?.exports.Tab       = Tab
