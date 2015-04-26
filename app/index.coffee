require('lib/setup')

Spine      = require('spine')
Navigation = require('controllers/navigation')
Content    = require('controllers/content')
$          = Spine.$

class App extends Spine.Controller
  constructor: ->
    super

    @navigation = new Navigation(el: $('#can-nav'))
    @content = new Content(el: $('#can-content'))
    @append @navigation
    @append @content

    Spine.Route.setup(
      redirect: true
      trigger: true
    )

module.exports = App
