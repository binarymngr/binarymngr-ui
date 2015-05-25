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

  destroy: (options) =>
    super
      done: -> Notification.error 'Binary has successfully been deleted.'
      fail: -> Notification.warning 'An error encountered during the deletion process.'

  getCategories: =>
    Category = require('models/binary_category')  # FIXME: Category = empty object if placed on top

    this.category_ids ?= new Array
    return (Category.find(category_id) for category_id in this.category_ids when Category.exists(category_id))

  getVersions: =>
    this.version_ids ?= new Array
    return (Version.find(version_id) for version_id in this.version_ids when Version.exists(version_id))

  hasCategories: =>
    return this.getCategories().length isnt 0

  hasVersions: =>
    return this.getVersions().length isnt 0

  isInstalled: =>
    _.each this.getVersions(), (version) ->
      return true if version.isInstalled()
    return false

  save: (options) =>
    super
      done: -> Notification.success 'Binary has successfully been saved.'
      fail: -> Notification.warning 'An error encountered during the save process.'

  validate: ->
    return 'Name is required' unless @name
    # return 'Owner ID is required' unless @owner_id

module?.exports = Binary
