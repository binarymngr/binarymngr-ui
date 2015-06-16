Spine          = @Spine or require('spine')
Administration = require('controllers/administration/page')
Binaries       = require('controllers/binaries/page')
Dashboard      = require('controllers/dashboard/page')
Messages       = require('controllers/messages/stack')
Servers        = require('controllers/servers/stack')

class Content extends Spine.Stack
  className: 'spine stack container-fluid'

  controllers:
    administration: Administration
    binaries      : Binaries
    dashboard     : Dashboard
    messages      : Messages
    servers       : Servers

  default: 'dashboard'

  routes:
    # FIXME: child stacks should not be needed
    '/administration/*glob': 'administration'
    '/binaries*glob'       : 'binaries'
    '/messages*glob'       : 'messages'
    '/servers*glob'        : 'servers'
    '/'                    : 'dashboard'

module?.exports = Content
