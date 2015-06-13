Spine        = @Spine or require 'spine'
Notification = require 'services/notification_service'
$            = Spine.$

class User extends Spine.Model
  @configure 'User', 'email', 'password', 'role_ids'

  @hasMany 'binaries', 'models/binary', 'owner_id'
  @hasMany 'messages', 'models/message', 'user_id'
  @hasMany 'servers',  'models/server', 'owner_id'

  @extend Spine.Model.Ajax
  @url: '/users'

  create: ->
    super
      done: -> Notification.success 'User has sucessfully been created.'
      fail: -> Notification.error   'An error encountered during the creation process.'

  destroy: ->
    super
      done: =>
        srv.destroy() for srv in @servers().all()
        Notification.warning 'User has successfully been deleted.'
      fail: -> Notification.error   'An error encountered during the deletion process.'

  getRoles: =>
    Role = require('models/role')
    @role_ids ?= new Array
    (Role.find(rid) for rid in @role_ids when Role.exists(rid))

  hasMessages:  => @messages().all().length isnt 0
  hasRoles:     => @getRoles().length isnt 0
  ownsBinaries: => @binaries().all().length isnt 0
  ownsServers:  => @servers().all().length isnt 0

  update: ->
    super
      done: -> Notification.success 'User has sucessfully been updated.'
      fail: -> Notification.error  'An error encountered during the update process.'

  validate: => 'Email is required' unless @email

module?.exports = User
