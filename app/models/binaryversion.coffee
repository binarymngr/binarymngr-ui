Spine = @Spine or require('spine')

class BinaryVersion extends Spine.Model
  @configure 'BinaryVersion', 'identifier', 'note', 'eol', 'binary_id'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @url: '/binaries/versions'

  validate: ->
    'Identifier is required' unless @identifier
    'Binary ID is required' unless @binary_id

module.exports = BinaryVersion
