Spine = @Spine or require 'spine'

#
# Spine model for the server-side \App\Models\Message model.
#
class Message extends Spine.Model
  @configure 'Message', 'title', 'body', 'created_at', 'user_id'

  @extend Spine.Model.Ajax

  @url: '/messages'

  #
  # override: For custom implementation.
  #
  validate: -> 'Messages are read-only and cannot be created'

module?.exports = Message
