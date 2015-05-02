Spine  = @Spine or require('spine')

class BinaryVersion extends Spine.Model
  @configure 'BinaryVersion', 'identifier', 'note', 'eol', 'binary_id'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @belongsTo 'binary', 'models/binary'  # 'models/binary' is a hack because it doesn't work with Binary

  @url: '/binaries/versions'

  validate: ->
    return 'Identifier is required' unless @identifier
    return 'Binary ID is required' unless @binary_id

module.exports = BinaryVersion
