Spine        = @Spine or require 'spine'
Notification = require 'services/notification_service'
User         = require 'models/user'

class Server extends Spine.Model
  @configure 'Server', 'name', 'ipv4', 'owner_id', 'binary_version_ids'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @belongsTo 'owner', User

  @url: '/servers'

  destroy: =>
    super
      done: -> Notification.error 'Server has successfully been deleted.'
      fail: -> Notification.warning 'An error encountered during the deletion process.'

  getBinaryVersions: =>
    Version = require 'models/binary_version'  # FIXME: fails with Binary = empty object if placed on top

    @binary_version_ids ?= new Array
    return (Version.find(version_id) for version_id in @binary_version_ids when Version.exists(version_id))

  hasBinariesInstalled: =>
    return @getBinaryVersions().length isnt 0

  @save: (server) ->
    if server.save()
      Notification.success 'Server has successfully been saved.'
    else
      Notification.warning 'An error encountered during the save process.'

  validate: ->
    return 'Name is required' unless @name
    return 'IPv4 address is required' unless @ipv4

module?.exports = Server
