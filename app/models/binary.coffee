Spine   = @Spine or require('spine')
User    = require('models/user')
Version = require('models/binary_version')

class Binary extends Spine.Model
  @configure 'Binary', 'name', 'description', 'homepage', 'owner_id'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @belongsTo 'owner', User
  @hasMany 'versions', Version

  @url: '/binaries'

  destroy: (options) =>
    super
      done: -> Notification.error 'Binary has successfully been deleted.'
      fail: -> Notification.warning 'An error encountered during the deletion process.'

  save: (options) =>
    super
      done: -> Notification.success 'Binary has successfully been saved.'
      fail: -> Notification.warning 'An error encountered during the save process.'

  validate: ->
    return 'Name is required' unless @name
    return 'Owner ID is required' unless @owner_id

module?.exports = Binary
