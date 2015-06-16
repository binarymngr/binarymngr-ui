Spine = @Spine or require('spine')
Form  = require('controllers/servers/page_form')
Table = require('controllers/servers/page_table')

class ServersStack extends Spine.Stack
  className: 'spine stack row'

  controllers:
    form : Form
    table: Table

  default: 'table'

  routes:
    '/servers/:id': 'form'
    '/servers'    : 'table'

module?.exports = ServersStack
