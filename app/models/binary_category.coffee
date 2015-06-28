Spine        = @Spine or require('spine')
Notification = require('services/notification_service')

class BinaryCategory extends Spine.Model
  @configure 'BinaryCategory', 'name', 'description'

  @extend Spine.Model.Ajax
  @url: '/binaries/categories'
  
  constructor: ->
    super
    b.trigger('update', b) for b in @binaries()

  binaries: =>
    Binary = require('models/binary')
    (Binary.select (b) => _.contains(b.binary_category_ids, @id))

  create: ->
    super
      done: -> Notification.success 'Binary category has sucessfully been created.'
      fail: -> Notification.error   'An error encountered during the creation process.'

  destroy: ->
    super
      done: =>
        b.removeCategory(@) for b in @binaries()
        Notification.warning 'Binary category has successfully been deleted.'
      fail: -> Notification.error   'An error encountered during the deletion process.'

  hasBinaries: => @binaries().length isnt 0

  update: ->
    super
      done: -> Notification.success 'Binary category has sucessfully been updated.'
      fail: -> Notification.error   'An error encountered during the update process.'

  validate: => 'Name is required' unless @name

module?.exports = BinaryCategory
