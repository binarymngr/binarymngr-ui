Spine          = @Spine or require('spine')
Administration = require('controllers/administration/page')
Binaries       = require('controllers/binaries/page')
Dashboard      = require('controllers/dashboard/page')
Servers        = require('controllers/servers/page')

class ContentComponent extends Spine.Stack
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

module?.exports = ContentComponent
