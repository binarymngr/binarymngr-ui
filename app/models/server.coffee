Spine        = @Spine or require('spine')
Notification = require('services/notification_service')

class Server extends Spine.Model
  @configure 'Server', 'name', 'ipv4', 'owner_id', 'binary_version_ids'

  @hasMany   'messages', 'models/message', 'server_id'
  @belongsTo 'owner',    'models/user'

  @extend Spine.Model.Ajax
  @url: '/servers'

  binary_versions: ->
    Version = require('models/binary_version')
    @binary_version_ids ?= new Array
    (Version.find(vid) for vid in @binary_version_ids when Version.exists(vid))

  create: ->
    super
      done: -> Notification.success 'Server has sucessfully been created.'
      fail: -> Notification.error   'An error encountered during the creation process.'

  destroy: ->
    super
      done: -> Notification.warning 'Server has successfully been deleted.'
      fail: -> Notification.error   'An error encountered during the deletion process.'

  detachBinaryVersion: (binary_version) =>
    _.remove(@binary_version_ids, (id) -> id is binary_version?.id)
    @trigger 'update', @

  hasBinariesInstalled: => @binary_versions().length isnt 0
  hasMessages:          => @messages().count() isnt 0

  update: ->
    super
      done: -> Notification.success 'Server has sucessfully been updated.'
      fail: -> Notification.error   'An error encountered during the update process.'

  validate: =>
    return 'Name is required' unless @name
    return 'IPv4 address is required' unless @ipv4

module?.exports = Server
