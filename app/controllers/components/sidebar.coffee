Spine      = @Spine or require('spine')
Controller = require('framework/core').Controller
$          = Spine.$

class Sidebar extends Controller
  className: 'col-sm-3 col-md-2 col-sm-pull-9 col-md-pull-10 sidebar-pf sidebar-pf-left'

  constructor: ->
    super
    @items = []

  addItem: (item) => @items.push item

  render: =>
    @el.empty()
    $.each @items, (i, item) => @append item.render()
    @el

class SidebarElement extends Controller

class NavBlock extends SidebarElement
  className: 'nav-category'

  constructor: ->
    super
    throw new Error('@nav is required') unless @nav
    throw new Error('@title is required') unless @title

  render: =>
    @el.empty()
    @html @title.render()
    @append @nav.render()
    @el

class Nav extends Controller
  className: 'items nav nav-pills nav-stacked'
  tag: 'ul'

  constructor: ->
    super
    @items = []

  addItem: (item) =>
    item.bind 'activated', @itemActivated
    @items.push item

  itemActivated: (activated) =>
    $.each @items, (i, item) -> item.deactivate() unless item is activated

  render: =>
    @el.empty()
    $.each @items, (i, item) => @append item.render()
    @el

class NavItem extends Controller
  tag: 'li'

  events:
    'click > a': 'clicked'

  constructor: ->
    super
    throw new Error('@link is required') unless @link
    throw new Error('@text is required') unless @text
    @router = Spine.Route.create()
    @router.add new RegExp("^#{@link}(\\/[^\\/])*$"), @activate

  activate: =>
    unless @isActive()
      @el.addClass 'active'
      @trigger 'activated', @
      @trigger 'toggled', @

  clicked: => @trigger 'clicked', @

  deactivate: =>
    if @isActive()
      @el.removeClass 'active'
      @trigger 'deactivated', @
      @trigger 'toggled', @

  isActive: => @el.hasClass 'active'
  render:   => @html $("<a href='/##{@link}'>#{@text}</a>")

  toggle: =>
    if @isActive()
      @deactivate()
    else @activate()

class Title extends SidebarElement
  constructor: ->
    super
    throw new Error('@text is required') unless @text

  render: => @html $("<h2 class='h5'>#{@text}</h2>")

class LinkTitle extends Title
  constructor: ->
    super
    throw new Error('@link is required') unless @link
    @router = Spine.Route.create()
    @router.add new RegExp("^#{@link}(\\/[^\\/])*$"), @activate

  activate: =>
    unless @isActive()
      @el.addClass 'active'
      @trigger 'activated', @
      @trigger 'toggled', @

  clicked: => @trigger 'clicked', @

  deactivate: =>
    if @isActive()
      @el.removeClass 'active'
      @trigger 'deactivated', @
      @trigger 'toggled', @

  isActive: => @el.hasClass 'active'
  render:   => @html $("<h2 class='h5'><a href='/##{@link}'>#{@text}</a></h2>")

  toggle: =>
    if @isActive()
      @deactivate()
    else @activate()

module?.exports                   = Sidebar
module?.exports.Element           = SidebarElement
# Navs
module?.exports.NavBlock          = NavBlock
module?.exports.NavBlock.Nav      = Nav
module?.exports.NavBlock.Nav.Item = NavItem
# Titles
module?.exports.Title             = Title
module?.exports.LinkTitle         = LinkTitle
