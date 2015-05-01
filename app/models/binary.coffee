Spine = @Spine or require('spine')

class Binary extends Spine.Model
  @configure 'Binary', 'name', 'description', 'homepage', 'owner_id'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @url: '/binaries'

  validate: ->
    'Name is required' unless @name
    'Owner ID is required' unless @owner_id

module.exports = Binary
