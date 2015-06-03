Spine        = @Spine or require 'spine'
Notification = require 'services/notification_service'

#
# Spine model for the server-side \App\Models\Server model.
#
class Server extends Spine.Model
  @configure 'Server', 'name', 'ipv4', 'owner_id', 'binary_version_ids'

  @extend Spine.Model.Ajax

  @belongsTo 'owner', 'models/user'

  @url: '/servers'

  #
  # override: To show notifications.
  #
  create: ->
    super
      done: -> Notification.success 'Server has sucessfully been created.'
      fail: -> Notification.errro   'An error encountered during the creation process.'

  #
  # override: To show notifications.
  #
  destroy: ->
    super
      done: -> Notification.warning 'Server has successfully been deleted.'
      fail: -> Notification.error   'An error encountered during the deletion process.'

  #
  # Returns an array of binary versions installed on this server.
  #
  # Note: The lookup is not real, the servers's binary_version_id property is used.
  #
  # return: Array
  #
  getBinaryVersions: ->
    Version = require 'models/binary_version'
    @binary_version_ids ?= new Array
    (Version.find(vid) for vid in @binary_version_ids when Version.exists(vid))

  #
  # Checks if binaries are installed on this server.
  #
  # return: Boolean true if at least one binary version is installed.
  #
  hasBinariesInstalled: -> @getBinaryVersions().length isnt 0

  #
  # override: To show notifications.
  #
  update: ->
    super
      done: -> Notification.success 'Server has sucessfully been updated.'
      fail: -> Notification.error   'An error encountered during the update process.'

  #
  # override: For custom implementation.
  #
  validate: ->
    return 'Name is required' unless @name
    return 'IPv4 address is required' unless @ipv4

module?.exports = Server
