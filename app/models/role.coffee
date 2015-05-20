Spine        = @Spine or require('spine')
Notification = require('services/notification_service')

class Role extends Spine.Model
  @configure 'Role', 'name', 'description'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @url: '/roles'

  destroy: (options) =>
    super
      done: -> Notification.error 'Role has successfully been deleted.'
      fail: -> Notification.warning 'An error encountered during the deletion process.'

  save: (options) =>
    super
      done: -> Notification.success 'Role has successfully been saved.'
      fail: -> Notification.warning 'An error encountered during the save process.'

  validate: ->
    return 'Name is required' unless @name

module?.exports = Role
