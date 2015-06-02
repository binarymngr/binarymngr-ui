Spine        = @Spine or require 'spine'
Notification = require 'services/notification_service'

class BinaryVersion extends Spine.Model
  @configure 'BinaryVersion', 'identifier', 'note', 'eol', 'binary_id', 'server_ids'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @belongsTo 'binary', 'models/binary'  # 'models/binary' is a hack because it doesn't work with Binary

  @url: '/binaries/versions'

  constructor: (object) ->
    object.eol = object.eol.substring(0, 10) if object?.eol?
    super

  create: ->
    super
      done: -> Notification.success 'Binary version has sucessfully been created.'
      fail: -> Notification.warning 'An error encountered during the creation process.'

  destroy: =>
    super
      done: -> Notification.error 'Binary version has successfully been deleted.'
      fail: -> Notification.warning 'An error encountered during the deletion process.'

  getServers: =>
    Server = require 'models/server'  # FIXME: fails with Server = empty object if placed on top

    @server_ids ?= new Array
    (Server.find(server_id) for server_id in @server_ids when Server.exists(server_id))

  isInstalled: => @getServers().length isnt 0

  update: ->
    super
      done: -> Notification.success 'Binary version has sucessfully been updated.'
      fail: -> Notification.warning 'An error encountered during the update process.'

  toJSON: (version) =>
    data = @attributes()
    if data?.eol?
      data.eol += " 00:00:00"
    data

  validate: ->
    return 'Identifier is required' unless @identifier
    return 'Binary ID is required' unless @binary_id

module?.exports = BinaryVersion
