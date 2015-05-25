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

  @extend Spine.Bindings

  constructor: ->
    super

    @user = null
    Binary.bind 'refresh change', @render
    Role.bind 'refresh change', @render
    Server.bind 'refresh change', @render
    User.bind 'refresh change', @render

    @routes
      '/administration/users/:id': (params) ->
        @render params

  cancel: (event) =>
    @navigate '/administration/users'

  destroy: (event) =>
    if @user.destroy()
      @navigate '/administration/users'

  render: (params) =>
    @user = User.find params.id
    @html @template @user
    @applyBindings() if @user?

  save: (event) =>
    event.preventDefault()

    # TODO: make password optional
    unless @user.save()
      msg = @user.validate()
      return alert msg

  template: (item) ->
    binaries = null
    binaries = item.binaries().all() if item?
    roles    = null
    roles    = item.getRoles() if item?
    servers  = null
    servers  = item.servers().all() if item?

    require('views/administration/users/form')
      binaries: binaries
      user: item
      roles: roles
      servers: servers

module?.exports = UserForm
