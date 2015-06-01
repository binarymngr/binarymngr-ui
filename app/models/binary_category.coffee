Spine        = @Spine or require 'spine'
Notification = require 'services/notification_service'

class BinaryCategory extends Spine.Model
  @configure 'BinaryCategory', 'name', 'description', 'binary_ids'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @url: '/binaries/categories'

  destroy: =>
    super
      done: -> Notification.error 'Binary category has successfully been deleted.'
      fail: -> Notification.warning 'An error encountered during the deletion process.'

  getBinaries: =>
    Binary = require 'models/binary'  # FIXME: Binary = empty object if placed on top

    @binary_ids ?= new Array
    return (Binary.find(binary_id) for binary_id in @binary_ids when Binary.exists(binary_id))

  hasBinaries: =>
    return @getBinaries().length isnt 0

  @save: (category) ->
    if category.save()
      Notification.success 'Binary category has successfully been saved.'
    else
      Notification.warning 'An error encountered during the save process.'

  validate: ->
    return 'Name is required' unless @name

module?.exports = BinaryCategory
