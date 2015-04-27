Spine = require('spine')
$     = Spine.$

class Navigation extends Spine.Controller
  @activeClass: 'active'

  elements:
    '.navbar-primary': 'primary_nav'
    '.navbar-utility': 'utility_nav'

  events:
    'click .navbar-primary a': 'primaryNavLinkClicked'

  constructor: ->
    super
    @html require('views/partials/navigation')()

  primaryNavLinkClicked: (event) ->
    link = $(event.target)
    @primary_nav.find('.' + Navigation.activeClass).removeClass(Navigation.activeClass)
    link.parent('li').addClass(Navigation.activeClass)
    link.addClass(Navigation.activeClass)

module.exports = Navigation
