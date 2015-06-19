require('lib/setup')

Spine          = @Spine or require('spine')
Binary         = require('models/binary')
BinaryCategory = require('models/binary_category')
BinaryVersion  = require('models/binary_version')
Content        = require('controllers/content')
Controller     = require('framework/core').Controller
Header         = require('controllers/header')
Message        = require('models/message')
Notification   = require('services/notification_service')
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
    @header = new Header
    @content = new Content

    # setup the routing
    Spine.Route.setup()
    Spine.Route.navigate '/'

    # initially fetch all model records
    $.when(
      # binaries
      Binary.ajax().fetch()
      .fail -> Notification.error 'Fetching binaries from the server failed.'
      # binary categories
      BinaryCategory.ajax().fetch()
      .fail -> Notification.error 'Fetching binary categories from the server failed.'
      # binary versions
      BinaryVersion.ajax().fetch()
      .fail -> Notification.error 'Fetching binary versions from the server failed.'
      # messages
      Message.ajax().fetch()
      .fail -> Notification.error 'Fetching messages from the server failed.'
      # roles
      Role.ajax().fetch()
      .fail -> Notification.error 'Fetching roles from the server failed.'
      # servers
      Server.ajax().fetch()
      .fail -> Notification.error 'Fetching servers from the server failed.'
      # users
      User.ajax().fetch()
      .fail -> Notification.error 'Fetching users from the server failed.'
    ).then =>
      @el.removeClass 'loading'  # loading spinner
      @render()
      $(window).trigger 'resize'  # PF sidebar height

  render: =>
    @html @header.render()
    @append @content

module?.exports = App
