require('lib/setup')

Spine      = @Spine or require('spine')
Binary     = require('models/binary')
Category   = require('models/binarycategory')
Content    = require('controllers/components/content')
Navigation = require('controllers/components/navigation')
Role       = require('models/role')
Server     = require('models/server')
User       = require('models/user')
Version    = require('models/binaryversion')
$          = Spine.$

class App extends Spine.Controller
  constructor: ->
    super

    @navigation = new Navigation(el: $('#can-nav'))
    @content = new Content(el: $('#can-content'))
    @append @navigation, @content

    Spine.Route.setup()
    @navigate '/'

    Binary.fetch()
    Category.fetch()
    Role.fetch()
    Server.fetch()
    User.fetch()
    Version.fetch()

module?.exports = App
