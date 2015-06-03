Spine        = @Spine or require 'spine'
Notification = require 'services/notification_service'

#
# Spine model for the server-side \App\Models\Binary model.
#
class Binary extends Spine.Model
  @configure 'Binary', 'name', 'description', 'homepage', 'owner_id', \
             'binary_category_ids', 'binary_version_ids'

  @extend Spine.Model.Ajax

  @belongsTo 'owner', 'models/user'
  @hasMany 'versions', 'models/binary_version'

  @url: '/binaries'

  #
  # Override: To show notifications.
  #
  create: ->
    super
      done: -> Notification.success 'Binary has sucessfully been created.'
      fail: -> Notification.error   'An error encountered during the creation process.'

  #
  # Override: To show notifications.
  #
  destroy: ->
    super
      done: -> Notification.warning 'Binary has successfully been deleted.'
      fail: -> Notification.error   'An error encountered during the deletion process.'

  #
  # Returns an array of categories this binary belongs to.
  #
  # Note: The lookup is not real, the binary's binary_category_ids property is used.
  #
  # return: Array
  #
  getCategories: =>
    Category = require 'models/binary_category'
    @binary_category_ids ?= new Array
    (Category.find(cid) for cid in @binary_category_ids when Category.exists(cid))

  #
  # Checks if this binary has categories associated with it.
  #
  # return: Boolean true if at least one category is associated with the binary.
  #
  hasCategories: -> @getCategories().length isnt 0

  #
  # Checks if this binary has versions.
  #
  # return: Boolean true if at least one version exists.
  #
  hasVersions: -> @versions().length isnt 0

  #
  # Checks if this binary is installed.
  #
  # return: Boolean true if installed on at least one server.
  #
  isInstalled: ->
    _.each @versions(), (version) -> return yes if version.isInstalled()
    no

  #
  # Override: To show notifications.
  #
  update: ->
    super
      done: -> Notification.success 'Binary has sucessfully been updated.'
      fail: -> Notification.warning 'An error encountered during the update process.'

  #
  # Override: For custom implementation.
  #
  validate: -> 'Name is required' unless @name

module?.exports = Binary
