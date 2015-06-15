Spine      = @Spine or require('spine')
Navigation = require('controllers/components/navigation')
Item       = require('controllers/components/navigation').Item
Link       = require('controllers/components/navigation').Link
Request    = require('lib/http/request')
$          = Spine.$

# TODO: messages dropdown
class UtilityNav extends Navigation
  className: 'nav navbar-nav navbar-utility'

  constructor: ->
    super
    # administration 1st level dropdown
    if Request.get().user.is_admin
      admin = new Dropdown(icon: 'pficon pficon-settings', \
                           text: 'Administration')
      admin.addItem new Link(link: '/administration/roles', text: 'Roles')
      admin.addItem new Link(link: '/administration/users', text: 'Users')
      @addItem admin
    # account 1st level dropdown
    account = new Dropdown(icon: 'pficon pficon-user', text: 'Account')
    account.addItem new Link(link: '/messages', text: 'Messages')
    account.addItem new Divider
    account.addItem new Link(link: '/auth/logout', text: 'Logout', \
                             external: true)
    @addItem account

class Divider extends Item
  className: 'divider'

  activate:   -> # NOP
  deactivate: -> # NOP

class Dropdown extends Item
  className: 'dropdown'

  events:
    'click > a' : 'triggered'

  constructor: ->
    super
    throw new Error('@text is required') unless @text
    @items = []

  addItem: (item) =>
    item.bind 'activated', @activate
    item.bind 'activated', @itemActivated
    @bind 'deactivated', item.deactivate
    @items.push item

  itemActivated: (activated) =>
    for item in @items
      item.deactivate() unless item is activated

  render: =>
    @html $("<a href='#' class='dropdown-toggle' data-toggle='dropdown'> \
              #{@text}<b class='caret'></b></a>")
    @$('a').prepend($("<span class='#{@icon}'></span>")) if @icon
    menu = $("<ul class='dropdown-menu'></ul>")
    $.each @items, (index, item) -> menu.append item.render()
    @append menu
    @el

  triggered: => @trigger 'triggered', @

class Submenu extends Dropdown
  className: 'dropdown-submenu'

  render: =>
    @html $("<a href='#' class='dropdown-toggle'>#{@text}</a>")
    menu = $("<ul class='dropdown-menu'></ul>")
    menu.append(item.render()) for item in @items
    @append menu
    @el

module?.exports          = UtilityNav
module?.exports.Divider  = Divider
module?.exports.Dropdown = Dropdown
module?.exports.Submenu  = Submenu
