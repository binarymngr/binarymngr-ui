Spine   = @Spine or require 'spine'
Role    = require 'models/role'
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

    @active @render
    @user = null
    User.bind 'refresh', @render

  cancel:  -> @navigate '/administration/users'
  destroy: -> @navigate '/administration/users' if @user.destroy()

  render: (user) =>
    if @isActive
      @user = User.find(user.id) if user?.id?
      @html @template @user
      if @user?
        @user.bind 'change', @render
        @applyBindings()

  save: (event) =>
    event.preventDefault()
    @user.role_ids = @$('.selectpicker').selectpicker('val')
    unless @user.save()
      msg = @user.validate()
      alert msg

  template: (user) ->
    require('views/administration/users/form')
      binaries: user?.binaries().all()
      messages: user?.messages().all()
      user: user
      roles: Role.all()
      servers: user?.servers().all()

module?.exports = UserForm
