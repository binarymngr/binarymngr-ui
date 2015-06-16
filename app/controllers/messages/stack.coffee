Spine = @Spine or require('spine')
Form  = require('controllers/messages/page_form')
Table = require('controllers/messages/page_table')

class MessagesStack extends Spine.Stack
  className: 'spine stack row'

  controllers:
    form : Form
    table: Table

  default: 'table'

  routes:
    '/messages/:id': 'form'
    '/messages'    : 'table'

module?.exports = MessagesStack
