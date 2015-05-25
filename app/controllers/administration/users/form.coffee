Spine  = @Spine or require('spine')
Binary = require('models/binary')
Role   = require('models/role')
Server = require('models/server')
User   = require('models/user')

class UserForm extends Spine.Controller
  events:
    'click .spine-cancel' : 'cancel'
    'click .spine-destroy': 'destroy'
    'submit .item'        : 'save'

  modelVar: 'user'
  bindings:
    # '.item input[name="id"]'      : 'id'
    '.item input[name="email"]'   : 'email'
    '.item input[name="password"]': 'password'
    '.item select[name="roles"]'  : 'role_ids'

  @extend Spine.Bindings

  constructor: ->
    super

    @user = null
    Binary.bind 'refresh', @render
    Role.bind 'refresh', @render
    Server.bind 'refresh', @render
    User.bind 'refresh', @render

    @routes
      '/administration/users/:id': (params) ->
        @render params

  cancel: (event) =>
    @navigate '/administration/users'

  destroy: (event) =>
    if @user.notifyDestroy()
      @navigate '/administration/users'

  render: (params) =>
    @user = User.find params.id if params?.id?
    @html @template @user
    @applyBindings() if @user?

  save: (event) =>
    event.preventDefault()

    # TODO: make password optional
    unless @user.notifySave()
      msg = @user.validate()
      return alert msg

  template: (item) ->
    binaries = null
    binaries = item.binaries().all() if item?
    servers  = null
    servers  = item.servers().all() if item?

    require('views/administration/users/form')
      binaries: binaries
      user: item
      roles: Role.all()
      servers: servers

module?.exports = UserForm
