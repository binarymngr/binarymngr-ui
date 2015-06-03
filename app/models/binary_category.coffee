Spine        = @Spine or require 'spine'
Notification = require 'services/notification_service'

#
# Spine model for the server-side \App\Models\BinaryCategory model.
#
class BinaryCategory extends Spine.Model
  @configure 'BinaryCategory', 'name', 'description', 'binary_ids'

  @extend Spine.Model.Ajax

  @url: '/binaries/categories'

  #
  # override: to bind to events
  #
  constructor: (object) ->
    super

    Binary = require 'models/binary'
    Binary.bind 'change', (b) =>
      @trigger 'change' if _.contains(b.binary_category_ids, @id) \
                           and not _.contains(@binary_ids, b.id)

  #
  # override: To show notifications.
  #
  create: ->
    super
      done: -> Notification.success 'Binary category has sucessfully been created.'
      fail: -> Notification.error   'An error encountered during the creation process.'

  #
  # override: To show notifications.
  #
  destroy: ->
    super
      done: -> Notification.warning 'Binary category has successfully been deleted.'
      fail: -> Notification.error   'An error encountered during the deletion process.'

  #
  # Returns an array of binary objects that are in this group.
  #
  # return: Array
  #
  getBinaries: ->
    Binary = require 'models/binary'
    # @binary_ids ?= new Array
    # (Binary.find(bid) for bid in @binary_ids when Binary.exists(bid))
    Binary.select (b) => _.contains(b.binary_category_ids, @id)

  #
  # Checks if binaries are in this category.
  #
  # return: Boolean true if at least one binary is in this category.
  #
  hasBinaries: -> @getBinaries().length isnt 0

  #
  # Override: To show notifications.
  #
  update: ->
    super
      done: -> Notification.success 'Binary category has sucessfully been updated.'
      fail: -> Notification.error   'An error encountered during the update process.'

  #
  # Override: For custom implementation.
  #
  validate: -> 'Name is required' unless @name

module?.exports = BinaryCategory
