Spine     = require('spine')
Dashboard = require('controllers/dashboard')
Binaries  = require('controllers/binaries')
Servers   = require('controllers/servers')

class Content extends Spine.Stack
  controllers:
    dashboard: Dashboard
    binaries:  Binaries
    servers:   Servers

  default: 'dashboard'

  routes: {
    '/binaries': 'binaries',
    '/servers' : 'servers',
    '/'        : 'dashboard'
  }

module.exports = Content
