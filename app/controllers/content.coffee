Spine          = require('spine')
Administration = require('controllers/administration/index')
Binaries       = require('controllers/binaries/index')
Dashboard      = require('controllers/dashboard')
Servers        = require('controllers/servers/main')

class Content extends Spine.Stack
  className: 'container-fluid spine stack'

  controllers:
    administration: Administration
    binaries:       Binaries
    dashboard:      Dashboard
    servers:        Servers

  default: 'dashboard'

  routes:
    '/administration/:page': 'administration'
    '/binaries'            : 'binaries'
    '/servers'             : 'servers'
    '/'                    : 'dashboard'

module.exports = Content
