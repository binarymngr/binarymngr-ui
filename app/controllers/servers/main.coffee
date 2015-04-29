Spine  = require('spine')
Single = require('controllers/servers/single')
Table  = require('controllers/servers/table')

class ServersMain extends Spine.Stack
  className: 'row page-servers spine stack'

  controllers:
    single: Single
    table:  Table

  default: 'table'

  routes:
    '/servers/:id': 'single'
    '/servers'    : 'table'

module.exports = ServersMain
