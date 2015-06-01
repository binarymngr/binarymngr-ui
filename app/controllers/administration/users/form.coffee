Spine   = @Spine or require 'spine'
Binary  = require 'models/binary'
Request = require 'lib/http/request'
Role    = require 'models/role'
Server  = require 'models/server'
User    = require 'models/user'

class UserForm extends Spine.Controller
  events:
    'click .spine-cancel' : 'cancel'
    'click .spine-destroy': 'destroy'
    'submit .item'        : 'save'

  modelVar: 'user'
  bindings:
    '.item input[name="email"]'   : 'email'
    '.item input[name="password"]': 'password'
    # '.item select[name="roles"]'  : 'role_ids'

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
    @user = User.find params.id if params?.id?
    @html @template @user
    @applyBindings() if @user?

  save: (event) =>
    event.preventDefault()

    @user.role_ids = @$('.selectpicker').selectpicker('val')  # FIXME: is a hack

    unless @user.isValid() and User.save(@user)
      msg = @user.validate()
      return alert msg

  template: (user) ->
    binaries = null
    binaries = user.binaries().all() if user?
    servers  = null
    servers  = user.servers().all() if user?

    require('views/administration/users/form')
      binaries: binaries
      user: user
      roles: Role.all()
      rqst: Request.get()
      servers: servers

module?.exports = UserForm
