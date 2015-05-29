Spine = @Spine or require('spine')

class Message extends Spine.Model
  @configure 'Message', 'title', 'body', 'created_at', 'user_id'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @url: '/messages'

  validate: ->
    return 'Messages are read-only and cannot be created'

module?.exports = Message
