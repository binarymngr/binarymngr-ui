Spine        = @Spine or require('spine')
Notification = require('services/notification_service')

class Role extends Spine.Model
  @configure 'Role', 'name', 'description', 'user_ids'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @url: '/roles'

  destroy: (options) =>
    super
      done: -> Notification.error 'Role has successfully been deleted.'
      fail: -> Notification.warning 'An error encountered during the deletion process.'

  getUsers: =>
    User = require('models/user')  # FIXME: fails with User = empty object if placed on top

    this.user_ids ?= new Array
    return (User.find(user_id) for user_id in this.user_ids when User.exists(user_id))

  hasUsers: =>
    return this.getUsers().length isnt 0

  save: (options) =>
    super
      done: -> Notification.success 'Role has successfully been saved.'
      fail: -> Notification.warning 'An error encountered during the save process.'

  validate: ->
    return 'Name is required' unless @name

module?.exports = Role
