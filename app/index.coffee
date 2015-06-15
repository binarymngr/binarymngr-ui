require('lib/setup')

Spine          = @Spine or require('spine')
Binary         = require('models/binary')
BinaryCategory = require('models/binary_category')
BinaryVersion  = require('models/binary_version')
Content        = require('controllers/content')
Controller     = require('framework/core').Controller
Header         = require('controllers/header')
Message        = require('models/message')
Request        = require('lib/http/request')
Role           = require('models/role')
Server         = require('models/server')
User           = require('models/user')
$              = Spine.$

class App extends Controller
  constructor: ->
    super

    # warn the user on page leave if transactions are still pending
    $(window).on 'beforeunload', ->
      '''Data is still being sent to the server;
      you may lose unsaved changes if you close the page.''' if Spine.Ajax.pending

    # create a new request object after every location change(/click)
    Spine.Route.bind 'change', => @delay Request.hydrate, 0  # FIXME

    # setup Ajax module to send the CSRF token with every request
    _.extend Spine.Ajax.defaults.headers,
      'X-CSRF-Token': Request.get().csrf_token

    # initialize the UI components
    header = new Header
    content = new Content

    # setup the routing
    Spine.Route.setup()
    Spine.Route.navigate '/'

    # render the UI
    @html header.render()
    @append content

    # initially fetch all model records
    BinaryCategory.fetch()
    Binary.fetch()
    BinaryVersion.fetch()
    Message.fetch()
    Role.fetch()
    Server.fetch()
    User.fetch()

module?.exports = App
