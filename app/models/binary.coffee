Spine   = @Spine or require('spine')
User    = require('models/user')
Version = require('models/binaryversion')

class Binary extends Spine.Model
  @configure 'Binary', 'name', 'description', 'homepage', 'owner_id'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @belongsTo 'owner', User
  @hasMany 'versions', Version

  @url: '/binaries'

  validate: ->
    return 'Name is required' unless @name
    return 'Owner ID is required' unless @owner_id

module?.exports = Binary
