Spine   = @Spine or require('spine')
Server  = require('controllers/servers/form')
Servers = require('controllers/servers/table')

class ServersPage extends Spine.Stack
  className: 'row page-servers spine stack'

  controllers:
    server:  Server
    servers: Servers

  default: 'servers'

  routes:
    '/servers/:id': 'server'
    '/servers'    : 'servers'

module.exports = ServersPage
