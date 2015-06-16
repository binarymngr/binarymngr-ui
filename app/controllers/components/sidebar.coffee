Spine      = @Spine or require('spine')
Controller = require('framework/core').Controller
Navigation = require('controllers/components/navigation')
$          = Spine.$

class Sidebar extends Controller
  className: 'col-sm-3 col-md-2 col-sm-pull-9 col-md-pull-10 sidebar-pf sidebar-pf-left'

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

class SidebarElement extends Controller
  activate: =>
    unless @isActive()
      @el.addClass 'active'
      @trigger 'activated', @

  deactivate: =>
    if @isActive()
      @el.removeClass 'active'
      @trigger 'deactivated', @

  isActive: => @el.hasClass 'active'

class Nav extends Navigation
  className: 'nav nav-pills nav-stacked'

class NavItem extends Navigation.Link

class NavBlock extends SidebarElement
  className: 'nav-category'

  constructor: ->
    super
    throw new Error('@nav is required') unless @nav
    throw new Error('@title is required') unless @title
    @nav.bind 'activated', => @trigger 'activated', @
    @title.bind 'activated', => @trigger 'activated', @
    @nav.bind 'activated', @title.deactivate
    @title.bind 'activated', @nav.deactivate
    @bind 'deactivated', @nav.deactivate
    @bind 'deactivated', @title.deactivate

  render: =>
    @html @title.render()
    @append @nav.render()

class Title extends SidebarElement
  className: 'h5'
  tag: 'h2'

  constructor: ->
    super
    throw new Error('@text is required') unless @text

  render: => @html @text

class LinkTitle extends Title
  constructor: ->
    super
    throw new Error('@link is required') unless @link
    @router = Spine.Route.create()
    @router.add new RegExp("^#{@link}(\\/[^\\/])*$"), @activate

  clicked: => @trigger 'clicked', @
  render:  => @html $("<a href='/##{@link}'>#{@text}</a>")

module?.exports           = Sidebar
module?.exports.Element   = SidebarElement
# Navs
module?.exports.Nav       = Nav
module?.exports.Nav.Item  = NavItem
module?.exports.NavBlock  = NavBlock
# Titles
module?.exports.Title     = Title
module?.exports.LinkTitle = LinkTitle
