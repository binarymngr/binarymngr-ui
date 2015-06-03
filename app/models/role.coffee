Spine        = @Spine or require 'spine'
Notification = require 'services/notification_service'

#
# Spine model for the server-side \App\Models\Role model.
#
class Role extends Spine.Model
  @configure 'Role', 'name', 'description', 'user_ids'

  @extend Spine.Model.Ajax

  @url: '/roles'

  #
  # override: to bind to events
  #
  constructor: (object) ->
    super

    User = require 'models/user'
    User.bind 'change', (u) =>
      @trigger 'change' if _.contains(u.role_ids, @id) \
                           and not _.contains(@user_ids, u.id)

  #
  # override: To show notifications.
  #
  create: ->
    super
      done: -> Notification.success 'Role has sucessfully been created.'
      fail: -> Notification.error  'An error encountered during the creation process.'

  #
  # override: To show notifications.
  #
  destroy: ->
    super
      done: -> Notification.warning 'Role has successfully been deleted.'
      fail: -> Notification.error   'An error encountered during the deletion process.'

  #
  # Returns an array of user objects belonging to this role.
  #
  # return: Array
  #
  getUsers: ->
    User = require 'models/user'
    # @user_ids ?= new Array
    # (User.find(uid) for uid in @user_ids when User.exists(uid))
    User.select (u) => _.contains(u.role_ids, @id)

  #
  # Checks if users are associated with this role.
  #
  # return: Boolean true if at least one user has this role.
  #
  hasUsers: -> @getUsers().length isnt 0

  #
  # override: To show notifications.
  #
  update: ->
    super
      done: -> Notification.success 'Role has sucessfully been updated.'
      fail: -> Notification.warning 'An error encountered during the update process.'

  #
  # override: For custom implementation.
  #
  validate: -> 'Name is required' unless @name

module?.exports = Role
