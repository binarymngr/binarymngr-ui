Spine        = @Spine or require('spine')
Message      = require('models/message')
Notification = require('services/notification_service')

class BinaryVersion extends Spine.Model
  @configure 'BinaryVersion', 'identifier', 'note', 'eol', 'binary_id'

  @belongsTo 'binary', 'models/binary'
  @hasMany 'messages', 'models/message', 'binary_version_id'

  @extend Spine.Model.Ajax
  @url: '/binaries/versions'

  constructor: (object) ->
    object.eol = object.eol.substring(0, 10) if object?.eol?
    super

    require('models/binary').bind 'refresh', => @trigger 'update', @  # FIXME: Binary.bind
    Message.bind 'refresh', => @trigger 'update', @

  create: ->
    super
      done: -> Notification.success 'Binary version has sucessfully been created.'
      fail: -> Notification.error   'An error encountered during the creation process.'

  destroy: ->
    super
      done: -> Notification.warning 'Binary version has successfully been deleted.'
      fail: -> Notification.error   'An error encountered during the deletion process.'

  getServers: =>
    Server = require 'models/server'
    Server.select (s) => _.contains(s.binary_version_ids, @id)

  hasMessages: => @messages().count() isnt 0
  isInstalled: => @getServers().length isnt 0

  update: ->
    super
      done: -> Notification.success 'Binary version has sucessfully been updated.'
      fail: -> Notification.error   'An error encountered during the update process.'

  toJSON: (version) =>
    data = @attributes()
    if data?.eol?.length isnt 0
      data.eol += " 00:00:00"
    else
      data.eol = null
    data

  validate: =>
    return 'Identifier is required' unless @identifier
    return 'Binary ID is required' unless @binary_id

module?.exports = BinaryVersion
