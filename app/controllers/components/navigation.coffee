Spine = @Spine or require('spine')

class NavigationComponent extends Spine.Controller
  elements:
    '.navbar-primary': 'primary_nav'
    '.navbar-utility': 'utility_nav'

  constructor: ->
    super

    @html require('views/components/navigation')()

module?.exports = NavigationComponent
