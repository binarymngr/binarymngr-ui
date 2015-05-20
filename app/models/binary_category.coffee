Spine        = @Spine or require('spine')
Notification = require('services/notification_service')

class BinaryCategory extends Spine.Model
  @configure 'BinaryCategory', 'name', 'description'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @url: '/binaries/categories'

  destroy: (options) =>
    super
      done: -> Notification.error 'Category has successfully been deleted.'
      fail: -> Notification.warning 'An error encountered during the deletion process.'

  save: (options) =>
    super
      done: -> Notification.success 'Category has successfully been saved.'
      fail: -> Notification.warning 'An error encountered during the save process.'

  validate: ->
    return 'Name is required' unless @name

module?.exports = BinaryCategory
