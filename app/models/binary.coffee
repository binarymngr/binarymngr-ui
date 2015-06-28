Spine        = @Spine or require('spine')
Notification = require('services/notification_service')

class Binary extends Spine.Model
  @configure 'Binary', 'name', 'description', 'homepage', 'owner_id', \
             'versions_gatherer', 'versions_gatherer_meta', \
             'binary_category_ids', 'binary_version_ids'

  @hasMany   'messages', 'models/message', 'binary_id'
  @belongsTo 'owner',    'models/user'
  @hasMany   'versions', 'models/binary_version'

  @extend Spine.Model.Ajax
  @url: '/binaries'
  
  constructor: ->
    super
    c.trigger('update', c) for c in @categories()
    m.trigger('update', m) for m in @messages()
    @owner()?.trigger 'update', @owner()
    v.trigger('update', v) for v in @versions()

  categories: =>
    Category = require('models/binary_category')
    @binary_category_ids ?= new Array
    (Category.find(cid) for cid in @binary_category_ids when Category.exists(cid))

  create: ->
    super
      done: -> Notification.success 'Binary has sucessfully been created.'
      fail: -> Notification.error   'An error encountered during the creation process.'

  destroy: =>
    m.destroy() for m in @messages().all()
    v.destroy() for v in @versions().all()
    super
      done: =>
        c.trigger('update', c) for c in @categories()
        @owner()?.trigger 'update', @owner()
        Notification.warning 'Binary has successfully been deleted.'
      fail: -> Notification.error   'An error encountered during the deletion process.'

  hasCategories:       => @categories().length isnt 0
  hasMessages:         => @messages().count() isnt 0
  hasVersions:         => @versions().length isnt 0
  hasVersionsGatherer: => @versions_gatherer isnt null

  isInstalled: =>
    _.each @versions(), (version) -> return yes if version.isInstalled()
    no

  removeCategory: (category) =>
    removed = _.remove(@binary_category_ids, (id) -> id is category?.id)
    @trigger('update', @) if removed.length isnt 0

  update: ->
    super
      done: -> Notification.success 'Binary has sucessfully been updated.'
      fail: -> Notification.warning 'An error encountered during the update process.'

  validate: => 'Name is required' unless @name

module?.exports = Binary
