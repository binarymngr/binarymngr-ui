Spine = @Spine or require('spine')

class Message extends Spine.Model
  @configure 'Message', 'title', 'body', 'created_at', \
             'binary_id', 'binary_version_id', 'server_id', 'user_id'

  @belongsTo 'binary', 'models/binary'
  @belongsTo 'binary_version', 'models/binary_version'
  @belongsTo 'server', 'models/server'
  @belongsTo 'user', 'models/user'

  @extend  Spine.Model.Ajax
  @url: '/messages'

  destroy: ->
    super
      done: -> Notification.warning 'Message has successfully been deleted.'
      fail: -> Notification.error   'An error encountered during the deletion process.'

  isForBinary:        => yes if @binary_id
  isForBinaryVersion: => yes if @binary_version_id
  isForServer:        => yes if @server_id

  validate: -> 'Messages are read-only and cannot be created'

module?.exports = Message
