Spine = require('spine')
$     = Spine.$

class Navigation extends Spine.Controller
  @active_class: 'active'

  elements:
    '.navbar-primary': 'primary_nav'
    '.navbar-utility': 'utility_nav'

  events:
    'click .navbar-primary a': 'primary_nav_link_clicked'

  constructor: ->
    super
    @html require('views/partials/navigation')()

  primary_nav_link_clicked: (event) ->
    link = $(event.target)
    @primary_nav.find('.' + Navigation.active_class).removeClass(Navigation.active_class)
    link.parent('li').addClass(Navigation.active_class)
    link.addClass(Navigation.active_class)

module.exports = Navigation
