require('lib/setup')

Spine      = @Spine or require('spine')
Binary     = require('models/binary')
Category   = require('models/binary_category')
Content    = require('controllers/components/content')
Navigation = require('controllers/components/navigation')
Request    = require('http/request')
Role       = require('models/role')
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
    Spine.Route.bind 'change', ->
      Request.hydrate()

    # setup Ajax module to send the CSRF token with every request
    _.extend Spine.Ajax.defaults.headers,
      'X-CSRF-Token': Request.get().csrf_token

    # setup the router and initial request
    Request.hydrate()
    Spine.Route.setup()
    Spine.Route.navigate '/'

    # bootstrap the UI
    @navigation = new Navigation(el: $('#can-nav'))
    @content = new Content(el: $('#can-content'))
    @append @navigation, @content

    # initially fetch all model records
    Binary.fetch()
    Category.fetch()
    Role.fetch()
    Server.fetch()
    User.fetch()
    Version.fetch()

module?.exports = App
