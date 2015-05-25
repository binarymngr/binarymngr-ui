Spine        = @Spine or require('spine')
Notification = require('services/notification_service')

class BinaryVersion extends Spine.Model
  @configure 'BinaryVersion', 'identifier', 'note', 'eol', 'binary_id', 'server_ids'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @belongsTo 'binary', 'models/binary'  # 'models/binary' is a hack because it doesn't work with Binary

  @url: '/binaries/versions'

  getServers: =>
    Server = require('models/server')  # FIXME: fails with Server = empty object if placed on top

    @server_ids ?= new Array
    return (Server.find(server_id) for server_id in @server_ids when Server.exists(server_id))

  isInstalled: =>
    return @getServers().length isnt 0

  notifyDestroy: =>
    @destroy
      done: -> Notification.error 'Binary version has successfully been deleted.'
      fail: -> Notification.warning 'An error encountered during the deletion process.'

  notifySave: =>
    @save
      done: -> Notification.success 'Binary version has successfully been saved.'
      fail: -> Notification.warning 'An error encountered during the save process.'

  validate: ->
    return 'Identifier is required' unless @identifier
    return 'Binary ID is required' unless @binary_id

module?.exports = BinaryVersion
