Spine        = @Spine or require('spine')
Notification = require('services/notification_service')
User         = require('models/user')
Version      = require('models/binary_version')

class Binary extends Spine.Model
  @configure 'Binary', 'name', 'description', 'homepage', 'owner_id', 'category_ids', 'version_ids'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @belongsTo 'owner', User
  @hasMany 'versions', Version

  @url: '/binaries'

  getCategories: =>
    Category = require('models/binary_category')  # FIXME: Category = empty object if placed on top

    @category_ids ?= new Array
    return (Category.find(category_id) for category_id in @category_ids when Category.exists(category_id))

  getVersions: =>
    @version_ids ?= new Array
    return (Version.find(version_id) for version_id in @version_ids when Version.exists(version_id))

  hasCategories: =>
    return @getCategories().length isnt 0

  hasVersions: =>
    return @getVersions().length isnt 0

  isInstalled: =>
    _.each @getVersions(), (version) ->
      return true if version.isInstalled()
    return false

  notifyDestroy: =>
    @destroy
      done: -> Notification.error 'Binary has successfully been deleted.'
      fail: -> Notification.warning 'An error encountered during the deletion process.'

  notifySave: (saved) ->
    if saved
      Notification.success 'Binary has successfully been saved.'
    else
      Notification.warning 'An error encountered during the save process.'

  validate: ->
    return 'Name is required' unless @name
    # return 'Owner ID is required' unless @owner_id

module?.exports = Binary
