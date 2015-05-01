Spine   = @Spine or require('spine')
User    = require('models/user')
Version = require('models/binaryversion')

class Binary extends Spine.Model
  @configure 'Binary', 'name', 'description', 'homepage', 'owner_id'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @belongsTo 'owner', User, 'owner_id'
  @hasMany 'versions', Version

  @url: '/binaries'

  validate: ->
    'Name is required' unless @name
    'Owner ID is required' unless @owner_id

module.exports = Binary
