Spine        = @Spine or require('spine')
Message      = require('models/message')
Notification = require('services/notification_service')
Role         = require('models/role')
Server       = require('models/server')

class User extends Spine.Model
  @configure 'User', 'email', 'password', 'role_ids'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @hasMany 'binaries', 'models/binary', 'owner_id'  # FIXME: 'models/binary' is a hack because it doesn't work with Binary
  @hasMany 'messages', Message, 'user_id'
  @hasMany 'servers', Server, 'owner_id'

  @url: '/users'

  destroy: =>
    super
      done: -> Notification.error 'User has successfully been deleted.'
      fail: -> Notification.warning 'An error encountered during the deletion process.'

  getRoles: =>
    @role_ids ?= new Array
    return (Role.find(role_id) for role_id in @role_ids when Role.exists(role_id))

  hasMessages: =>
    return @messages().length isnt 0

  hasRoles: =>
    return @getRoles().length isnt 0

  ownsBinaries: =>
    return @binaries().length isnt 0

  ownsServers: =>
    return @servers().length isnt 0

  @save: (user) ->
    if user.save()
      Notification.success 'User has successfully been saved.'
    else
      Notification.warning 'An error encountered during the save process.'

  validate: ->
    return 'Email is required' unless @email
    return 'Password is required' unless @password

module?.exports = User
