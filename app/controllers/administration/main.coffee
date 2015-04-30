Spine = @Spine or require('spine')
Roles = require('controllers/administration/stacks/roles')
Users = require('controllers/administration/stacks/users')

class AdministrationMain extends Spine.Stack
  className: 'col-sm-9 col-md-10 col-sm-push-3 col-md-push-2 spine stack'

  controllers:
    roles: Roles
    users: Users

  default: 'roles'

  routes:
    '/administration/roles': 'roles'
    '/administration/users': 'users'

module.exports = AdministrationMain
