Spine        = @Spine or require('spine')
Notification = require('services/notification_service')

class BinaryCategory extends Spine.Model
  @configure 'BinaryCategory', 'name', 'description'

  @extend Spine.Model.Ajax
  @url: '/binaries/categories'

  create: ->
    super
      done: -> Notification.success 'Binary category has sucessfully been created.'
      fail: -> Notification.error   'An error encountered during the creation process.'

  destroy: ->
    super
      done: -> Notification.warning 'Binary category has successfully been deleted.'
      fail: -> Notification.error   'An error encountered during the deletion process.'

  getBinaries: =>
    Binary = require('models/binary')
    Binary.select (b) => _.contains(b.binary_category_ids, @id)

  hasBinaries: => @getBinaries().length isnt 0

  update: ->
    super
      done: -> Notification.success 'Binary category has sucessfully been updated.'
      fail: -> Notification.error   'An error encountered during the update process.'

  validate: => 'Name is required' unless @name

module?.exports = BinaryCategory
