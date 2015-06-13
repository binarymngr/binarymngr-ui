Spine          = @Spine or require('spine')
Administration = require('controllers/administration/page')
Binaries       = require('controllers/binaries/page')
Dashboard      = require('controllers/dashboard/page')
Messages       = require('controllers/messages/stack')
Servers        = require('controllers/servers/stack')
Stack          = require('framework/managers').Stack

class Content extends Stack
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
    '/administration/roles/:id': 'administration'
    '/administration/roles'    : 'administration'
    '/administration/users/:id': 'administration'
    '/administration/users'    : 'administration'
    # binaries
    '/binaries/versions/:id'   : 'binaries'
    '/binaries/versions'       : 'binaries'
    '/binaries/categories/:id' : 'binaries'
    '/binaries/categories'     : 'binaries'
    '/binaries/:id'            : 'binaries'
    '/binaries'                : 'binaries'
    # messages
    '/messages/:id'            : 'messages'
    '/messages'                : 'messages'
    # servers
    '/servers/:id'             : 'servers'
    '/servers'                 : 'servers'
    # dashboard
    '/'                        : 'dashboard'

module?.exports = Content
