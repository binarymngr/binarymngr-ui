Spine        = @Spine or require 'spine'
Message      = require 'models/message'
Notification = require 'services/notification_service'
Role         = require 'models/role'
Server       = require 'models/server'

class User extends Spine.Model
  @configure 'User', 'email', 'password', 'role_ids'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @hasMany 'binaries', 'models/binary', 'owner_id'  # FIXME: 'models/binary' is a hack because it doesn't work with Binary
  @hasMany 'messages', Message, 'user_id'
  @hasMany 'servers', Server, 'owner_id'

  @url: '/users'

  create: ->
    super
      done: -> Notification.success 'User has sucessfully been created.'
      fail: -> Notification.warning 'An error encountered during the creation process.'

  destroy: ->
    super
      done: -> Notification.error 'User has successfully been deleted.'
      fail: -> Notification.warning 'An error encountered during the deletion process.'

  getRoles: =>
    @role_ids ?= new Array
    (Role.find(role_id) for role_id in @role_ids when Role.exists(role_id))

  hasMessages:  => @messages().length isnt 0
  hasRoles:     => @getRoles().length isnt 0
  ownsBinaries: => @binaries().length isnt 0
  ownsServers:  => @servers().length isnt 0

  update: ->
    super
      done: -> Notification.success 'User has sucessfully been updated.'
      fail: -> Notification.warning 'An error encountered during the update process.'

  validate: ->
    return 'Email is required' unless @email
    # return 'Password is required' unless @password

module?.exports = User
