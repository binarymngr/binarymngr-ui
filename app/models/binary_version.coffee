Spine        = @Spine or require 'spine'
Notification = require 'services/notification_service'

#
# Spine model for the server-side \App\Models\BinaryVersion model.
#
class BinaryVersion extends Spine.Model
  @configure 'BinaryVersion', 'identifier', 'note', 'eol', 'binary_id', \
             'server_ids'

  @extend Spine.Model.Ajax

  @belongsTo 'binary', 'models/binary'

  @url: '/binaries/versions'

  #
  # override: to remove the time from EOL and bind to events
  #
  constructor: (object) ->
    object.eol = object.eol.substring(0, 10) if object?.eol?
    super

    Server = require 'models/server'
    Server.bind 'change', (s) =>
      @trigger 'change' if _.contains(s.binary_version_ids, @id) \
                           and not _.contains(@server_ids, s.id)

  #
  # override: To show notifications.
  #
  create: ->
    super
      done: -> Notification.success 'Binary version has sucessfully been created.'
      fail: -> Notification.error   'An error encountered during the creation process.'

  #
  # override: To show notifications.
  #
  destroy: ->
    super
      done: -> Notification.warning 'Binary version has successfully been deleted.'
      fail: -> Notification.error   'An error encountered during the deletion process.'

  #
  # Returns an array of server objects this binary version is installed on.
  #
  # return: Array
  #
  getServers: ->
    Server = require 'models/server'
    # @server_ids ?= new Array
    # (Server.find(sid) for sid in @server_ids when Server.exists(sid))
    Server.select (s) => _.contains(s.binary_version_ids, @id)

  #
  # Checks if this binary version is installed.
  #
  # return: Boolean true if installed on at least one server.
  #
  isInstalled: -> @getServers().length isnt 0

  #
  # override: To show notifications.
  #
  update: ->
    super
      done: -> Notification.success 'Binary version has sucessfully been updated.'
      fail: -> Notification.error   'An error encountered during the update process.'

  #
  # override: to add a time to the EOL
  #
  toJSON: (version) ->
    data = @attributes()
    if data?.eol?
      data.eol += " 00:00:00"
    data

  #
  # override: For custom implementation.
  #
  validate: ->
    return 'Identifier is required' unless @identifier
    return 'Binary ID is required' unless @binary_id

module?.exports = BinaryVersion
