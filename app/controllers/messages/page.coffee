Spine    = @Spine or require 'spine'
Message  = require 'controllers/messages/form'
Messages = require 'controllers/messages/table'

class MessagesPage extends Spine.Stack
  className: 'row page-messages spine stack'

  controllers:
    message:  Message
    messages: Messages

  default: 'messages'

  routes:
    '/messages/:id': 'message'
    '/messages'    : 'messages'

module?.exports = MessagesPage
