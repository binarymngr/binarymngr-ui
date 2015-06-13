Spine = @Spine or require('spine')
Stack = require('framework/managers').Stack
Role  = require('controllers/administration/roles/page_form')
Roles = require('controllers/administration/roles/page_table')
User  = require('controllers/administration/users/page_form')
Users = require('controllers/administration/users/page_table')

class AdministrationStack extends Stack
  className: 'spine stack col-sm-9 col-md-10 col-sm-push-3 col-md-push-2'

  controllers:
    role : Role
    roles: Roles
    user : User
    users: Users

  default: 'roles'

  routes:
    '/administration/roles/:id': 'role'
    '/administration/roles'    : 'roles'
    '/administration/users/:id': 'user'
    '/administration/users'    : 'users'

module?.exports = AdministrationStack
