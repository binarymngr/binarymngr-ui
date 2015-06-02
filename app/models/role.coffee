Spine        = @Spine or require 'spine'
Notification = require 'services/notification_service'

class Role extends Spine.Model
  @configure 'Role', 'name', 'description', 'user_ids'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @url: '/roles'

  create: ->
    super
      done: -> Notification.success 'Role has sucessfully been created.'
      fail: -> Notification.warning 'An error encountered during the creation process.'

  destroy: =>
    super
      done: -> Notification.error 'Role has successfully been deleted.'
      fail: -> Notification.warning 'An error encountered during the deletion process.'

  getUsers: =>
    User = require 'models/user'  # FIXME: fails with User = empty object if placed on top

    @user_ids ?= new Array
    (User.find(user_id) for user_id in @user_ids when User.exists(user_id))

  hasUsers: => @getUsers().length isnt 0

  update: ->
    super
      done: -> Notification.success 'Role has sucessfully been updated.'
      fail: -> Notification.warning 'An error encountered during the update process.'

  validate: ->
    return 'Name is required' unless @name

module?.exports = Role
