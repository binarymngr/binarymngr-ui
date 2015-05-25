Spine        = @Spine or require('spine')
Notification = require('services/notification_service')

class BinaryCategory extends Spine.Model
  @configure 'BinaryCategory', 'name', 'description', 'binary_ids'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @url: '/binaries/categories'

  destroy: (options) =>
    super
      done: -> Notification.error 'Binary category has successfully been deleted.'
      fail: -> Notification.warning 'An error encountered during the deletion process.'

  getBinaries: =>
    Binary = require('models/binary')  # FIXME: Binary = empty object if placed on top

    this.binary_ids ?= new Array
    return (Binary.find(binary_id) for binary_id in this.binary_ids when Binary.exists(binary_id))

  hasBinaries: =>
    return this.getBinaries().length isnt 0

  save: (options) =>
    super
      done: -> Notification.success 'Binary category has successfully been saved.'
      fail: -> Notification.warning 'An error encountered during the save process.'

  validate: ->
    return 'Name is required' unless @name

module?.exports = BinaryCategory
