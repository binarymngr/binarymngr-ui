Spine        = @Spine or require('spine')
Notification = require('services/notification_service')
Role         = require('models/role')
Server       = require('models/server')

class User extends Spine.Model
  @configure 'User', 'email', 'password', 'role_ids'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @hasMany 'binaries', 'models/binary', 'owner_id'  # FIXME: 'models/binary' is a hack because it doesn't work with Binary
  @hasMany 'servers', Server, 'owner_id'

  @url: '/users'

  destroy: (options) =>
    super
      done: -> Notification.error 'User has successfully been deleted.'
      fail: -> Notification.warning 'An error encountered during the deletion process.'

  getRoles: =>
    this.role_ids ?= new Array
    return (Role.find(role_id) for role_id in this.role_ids when Role.exists(role_id))

  hasRoles: =>
    return this.getRoles().length isnt 0

  ownsBinaries: =>
    return this.binaries().length isnt 0

  ownsServers: =>
    return this.servers().length isnt 0

  save: (options) =>
    super
      done: -> Notification.success 'Server has successfully been saved.'
      fail: -> Notification.warning 'An error encountered during the save process.'

  validate: ->
    return 'Email is required' unless @email
    return 'Password is required' unless @password

module?.exports = User
