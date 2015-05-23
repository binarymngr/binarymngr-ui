Spine        = @Spine or require('spine')
Notification = require('services/notification_service')
Server       = require('models/server')

class User extends Spine.Model
  @configure 'User', 'email', 'password'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @hasMany 'binaries', 'models/binary', 'owner_id'  # 'models/binary' is a hack because it doesn't work with Binary
  @hasMany 'servers', Server, 'owner_id'

  @url: '/users'

  destroy: (options) =>
    super
      done: -> Notification.error 'User has successfully been deleted.'
      fail: -> Notification.warning 'An error encountered during the deletion process.'

  save: (options) =>
    super
      done: -> Notification.success 'Server has successfully been saved.'
      fail: -> Notification.warning 'An error encountered during the save process.'

  validate: ->
    return 'Email is required' unless @email
    return 'Password is required' unless @password

module?.exports = User
