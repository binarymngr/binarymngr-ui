Spine  = @Spine or require('spine')
Single = require('controllers/servers/stacks/single')
Table  = require('controllers/servers/stacks/table')

class ServersPage extends Spine.Stack
  className: 'row page-servers spine stack'

  controllers:
    single: Single
    table:  Table

  default: 'table'

  routes:
    '/servers/:id': 'single'
    '/servers'    : 'table'

module.exports = ServersPage
