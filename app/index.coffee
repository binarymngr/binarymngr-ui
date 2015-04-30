require('lib/setup')

Spine      = @Spine or require('spine')
Navigation = require('controllers/components/navigation')
Content    = require('controllers/components/content')
$          = Spine.$

class App extends Spine.Controller
  constructor: ->
    super

    @navigation = new Navigation(el: $('#can-nav'))
    @content = new Content(el: $('#can-content'))
    @append @navigation, @content

    Spine.Route.setup()
    @navigate '/'

module.exports = App
