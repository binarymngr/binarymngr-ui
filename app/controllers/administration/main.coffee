Spine = @Spine or require 'spine'
Role  = require 'controllers/administration/roles/form'
Roles = require 'controllers/administration/roles/table'
User  = require 'controllers/administration/users/form'
Users = require 'controllers/administration/users/table'

class AdministrationMain extends Spine.Stack
  className: 'col-sm-9 col-md-10 col-sm-push-3 col-md-push-2 spine stack'

  controllers:
    role:  Role
    roles: Roles
    user:  User
    users: Users

  default: 'roles'

  routes:
    '/administration/roles/:id': 'role'
    '/administration/roles'    : 'roles'
    '/administration/users/:id': 'user'
    '/administration/users'    : 'users'

module?.exports = AdministrationMain
