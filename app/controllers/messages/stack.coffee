Spine = @Spine or require('spine')
Form  = require('controllers/messages/page_form')
Stack = require('framework/managers').Stack
Table = require('controllers/messages/page_table')

class MessagesStack extends Stack
  className: 'spine stack row'

  controllers:
    form : Form
    table: Table

  default: 'table'

  routes:
    '/messages/:id': 'form'
    '/messages'    : 'table'

module?.exports = MessagesStack
