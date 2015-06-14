Spine        = @Spine or require 'spine'
Notification = require 'services/notification_service'

class Role extends Spine.Model
  @configure 'Role', 'name', 'description'

  @extend Spine.Model.Ajax
  @url: '/roles'

  create: ->
    super
      done: -> Notification.success 'Role has sucessfully been created.'
      fail: -> Notification.error  'An error encountered during the creation process.'

  destroy: ->
    super
      done: -> Notification.warning 'Role has successfully been deleted.'
      fail: -> Notification.error   'An error encountered during the deletion process.'

  @fetch: ->
    super
      fail: -> Notification.error 'Fetching roles from the remote server failed.'

  getUsers: =>
    User = require 'models/user'
    User.select (u) => _.contains(u.role_ids, @id)

  hasUsers: => @getUsers().length isnt 0

  update: ->
    super
      done: -> Notification.success 'Role has sucessfully been updated.'
      fail: -> Notification.warning 'An error encountered during the update process.'

  validate: => 'Name is required' unless @name

module?.exports = Role
