Spine        = @Spine or require 'spine'
Notification = require 'services/notification_service'

class BinaryCategory extends Spine.Model
  @configure 'BinaryCategory', 'name', 'description', 'binary_ids'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @url: '/binaries/categories'

  create: ->
    super
      done: -> Notification.success 'Binary category has sucessfully been created.'
      fail: -> Notification.warning 'An error encountered during the creation process.'

  destroy: =>
    super
      done: -> Notification.error 'Binary category has successfully been deleted.'
      fail: -> Notification.warning 'An error encountered during the deletion process.'

  getBinaries: =>
    Binary = require 'models/binary'  # FIXME: Binary = empty object if placed on top

    @binary_ids ?= new Array
    (Binary.find(binary_id) for binary_id in @binary_ids when Binary.exists(binary_id))

  hasBinaries: => @getBinaries().length isnt 0

  update: ->
    super
      done: -> Notification.success 'Binary category has sucessfully been updated.'
      fail: -> Notification.warning 'An error encountered during the update process.'

  validate: ->
    return 'Name is required' unless @name

module?.exports = BinaryCategory
