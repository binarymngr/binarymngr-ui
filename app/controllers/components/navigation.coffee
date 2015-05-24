Spine   = @Spine or require('spine')
Request = require('http/request')

class NavigationComponent extends Spine.Controller
  elements:
    '.navbar-primary': 'primary_nav'
    '.navbar-utility': 'utility_nav'

  constructor: ->
    super

    @html require('views/components/navigation')
      rqst: Request.get()

module?.exports = NavigationComponent
