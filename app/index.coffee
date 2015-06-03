require 'lib/setup'

Spine      = @Spine or require 'spine'
Binary     = require 'models/binary'
Category   = require 'models/binary_category'
Content    = require 'controllers/components/content'
Message    = require 'models/message'
Navigation = require 'controllers/components/navigation'
Request    = require 'lib/http/request'
Role       = require 'models/role'
Server     = require 'models/server'
User       = require 'models/user'
Version    = require 'models/binary_version'
$          = Spine.$

class App extends Spine.Controller
  constructor: ->
    super

    # warn the user on page leave if transactions are still pending
    $(window).on 'beforeunload', ->
      '''Data is still being sent to the server;
      you may lose unsaved changes if you close the page.''' if Spine.Ajax.pending

    # create a new request object after every location change(/click)
    Spine.Route.bind 'change', (opts) -> Request.hydrate()

    # setup Ajax module to send the CSRF token with every request
    _.extend Spine.Ajax.defaults.headers,
      'X-CSRF-Token': Request.get().csrf_token

    # setup the router
    Spine.Route.setup()
    Spine.Route.navigate '/'

    # bootstrap the UI
    @navigation = new Navigation el: $('#can-nav')
    @content = new Content el: $('#can-content')
    @append @navigation, @content

    # initially fetch all model records
    Message.fetch()
    Binary.fetch()
    Category.fetch()
    Version.fetch()
    Server.fetch()
    Role.fetch()
    User.fetch()

module?.exports = App
