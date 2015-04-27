Spine = require('spine')
$     = Spine.$

class Navigation extends Spine.Controller
  @activeClass: 'active'

  elements:
    '.navbar-primary': 'primary_nav'
    '.navbar-utility': 'utility_nav'

  constructor: ->
    super
    @html require('views/partials/navigation')()

module.exports = Navigation
