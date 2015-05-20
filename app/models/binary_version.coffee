Spine        = @Spine or require('spine')
Notification = require('services/notification_service')

class BinaryVersion extends Spine.Model
  @configure 'BinaryVersion', 'identifier', 'note', 'eol', 'binary_id'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @belongsTo 'binary', 'models/binary'  # 'models/binary' is a hack because it doesn't work with Binary

  @url: '/binaries/versions'

  destroy: (options) =>
    super
      done: -> Notification.error 'Version has successfully been deleted.'
      fail: -> Notification.warning 'An error encountered during the deletion process.'

  save: (options) =>
    super
      done: -> Notification.success 'Version has successfully been saved.'
      fail: -> Notification.warning 'An error encountered during the save process.'

  validate: ->
    return 'Identifier is required' unless @identifier
    return 'Binary ID is required' unless @binary_id

module?.exports = BinaryVersion
