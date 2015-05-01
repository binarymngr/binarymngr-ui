Spine  = @Spine or require('spine')
Binary = require('models/binary')

class BinaryVersion extends Spine.Model
  @configure 'BinaryVersion', 'identifier', 'note', 'eol', 'binary_id'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @configure 'BinaryVersion', 'identifier', 'note', 'eol', 'binary_id'
  @belongsTo 'binary', Binary, 'binary_id'

  @url: '/binaries/versions'

  validate: ->
    'Identifier is required' unless @identifier
    'Binary ID is required' unless @binary_id

module.exports = BinaryVersion
