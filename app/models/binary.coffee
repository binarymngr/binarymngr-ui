Spine        = @Spine or require 'spine'
Notification = require 'services/notification_service'
User         = require 'models/user'
Version      = require 'models/binary_version'

class Binary extends Spine.Model
  @configure 'Binary', 'name', 'description', 'homepage', 'owner_id', 'category_ids', 'version_ids'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @belongsTo 'owner', User
  @hasMany 'versions', Version

  @url: '/binaries'

  create: ->
    super
      done: -> Notification.success 'Binary has sucessfully been created.'
      fail: -> Notification.warning 'An error encountered during the creation process.'

  destroy: =>
    super
      done: -> Notification.error 'Binary has successfully been deleted.'
      fail: -> Notification.warning 'An error encountered during the deletion process.'

  getCategories: =>
    Category = require 'models/binary_category'  # FIXME: Category = empty object if placed on top

    @category_ids ?= new Array
    (Category.find(category_id) for category_id in @category_ids when Category.exists(category_id))

  hasCategories: => @getCategories().length isnt 0
  hasVersions:   => @versions().length isnt 0

  isInstalled: =>
    _.each @versions(), (version) ->
      return yes if version.isInstalled()
    no

  update: ->
    super
      done: -> Notification.success 'Binary has sucessfully been updated.'
      fail: -> Notification.warning 'An error encountered during the update process.'

  validate: ->
    return 'Name is required' unless @name
    # return 'Owner ID is required' unless @owner_id

module?.exports = Binary
