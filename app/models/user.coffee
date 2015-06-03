Spine        = @Spine or require 'spine'
Notification = require 'services/notification_service'

#
# Spine model for the server-side \App\Models\User model.
#
class User extends Spine.Model
  @configure 'User', 'email', 'password', 'role_ids'

  @extend Spine.Model.Ajax

  @hasMany 'binaries', 'models/binary',  'owner_id'
  @hasMany 'messages', 'models/message', 'user_id'
  @hasMany 'servers',  'models/server',  'owner_id'

  @url: '/users'

  #
  # override: To show notifications.
  #
  create: ->
    super
      done: -> Notification.success 'User has sucessfully been created.'
      fail: -> Notification.error   'An error encountered during the creation process.'

  #
  # override: To show notifications.
  #
  destroy: ->
    super
      done: -> Notification.warning 'User has successfully been deleted.'
      fail: -> Notification.error   'An error encountered during the deletion process.'

  #
  # Returns an array of role objects this user belongs to.
  #
  # Note: The lookup is not real, the users's role_ids property is used.
  #
  # return: Array
  #
  getRoles: ->
    Role = require 'models/role'
    @role_ids ?= new Array
    (Role.find(rid) for rid in @role_ids when Role.exists(rid))

  #
  # Checks if messages exist for this user.
  #
  # return: Boolean true if at least one message exists.
  #
  hasMessages: -> @messages().length isnt 0

  #
  # Checks if the user belongs to a role.
  #
  # return: Boolean true if the user belongs to at least one role.
  #
  hasRoles: -> @getRoles().length isnt 0

  #
  # Checks if users owns binaries.
  #
  # return: Boolean true if the user owns at least one binary.
  #
  ownsBinaries: -> @binaries().length isnt 0

  #
  # Checks if the user owns servers.
  #
  # return: Boolean true if the user owns at least one server.
  #
  ownsServers: -> @servers().length isnt 0

  #
  # override: To show notifications.
  #
  update: ->
    super
      done: -> Notification.success 'User has sucessfully been updated.'
      fail: -> Notification.error  'An error encountered during the update process.'

  #
  # override: For custom implementation.
  #
  validate: -> 'Email is required' unless @email

module?.exports = User
