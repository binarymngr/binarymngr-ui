Spine = require('spine')

class Binary extends Spine.Model
  @configure 'Binary', 'name', 'description', 'homepage', 'owner'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @url: '/binaries'

  validate: ->
    'Name is required' unless @name
    'Owner is required' unless @owner

module.exports = Binary
