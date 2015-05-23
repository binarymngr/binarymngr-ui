require('lib/setup')

Spine      = @Spine or require('spine')
Binary     = require('models/binary')
Category   = require('models/binary_category')
Content    = require('controllers/components/content')
Navigation = require('controllers/components/navigation')
Request    = require('http/request')
Role       = require('models/role')
Route      = Spine.Route
Server     = require('models/server')
User       = require('models/user')
Version    = require('models/binary_version')
$          = Spine.$

class App extends Spine.Controller
  constructor: ->
    super

    # warn the user on page leave if transactions are still pending
    $(window).on 'beforeunload', ->
      if Spine.Ajax.pending
        return 'Data is still being sent to the server; you may lose unsaved changes if you close the page.'

    # create a new request object after every location change(/click?)
    Route.bind 'change', ->
      Request.setCurrent(new Request)

    # setup the router and the initial request
    Route.setup()
    Route.navigate('/')
    Request.setCurrent(new Request)

    # initially fetch all model records
    Binary.fetch()
    Category.fetch()
    Role.fetch()
    Server.fetch()
    User.fetch()
    Version.fetch()

    # bootstrap the UI
    @navigation = new Navigation(el: $('#can-nav'))
    @content = new Content(el: $('#can-content'))
    @append @navigation, @content

module?.exports = App
