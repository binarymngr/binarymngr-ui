Spine = @Spine or require('spine')
Form  = require('controllers/servers/page_form')
Stack = require('framework/managers').Stack
Table = require('controllers/servers/page_table')

class ServersStack extends Stack
  className: 'spine stack row'

  controllers:
    form : Form
    table: Table

  default: 'table'

  routes:
    '/servers/:id': 'form'
    '/servers'    : 'table'

module?.exports = ServersStack
