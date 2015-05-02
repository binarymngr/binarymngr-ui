Spine = @Spine or require('spine')
User  = require('models/user')

class UserForm extends Spine.Controller
  events:
    'click .can-cancel' : 'cancel'
    'click .can-destroy': 'destroy'
    'click .can-save'   : 'save'

  modelVar: 'user'
  bindings:
    # '.item input[name="id"]'      : 'id'
    '.item input[name="email"]'   : 'email'
    '.item input[name="password"]': 'password'

  @extend Spine.Bindings

  constructor: ->
    super

    @user = null
    User.bind('refresh change', @render)

    @routes
      '/administration/users/:id': (params) ->
        @render params

  cancel: (event) =>
    @navigate('/administration/users')

  destroy: (event) =>
    if @user.destroy()
      @navigate('/administration/users')
    else
      return alert('Something went wrong')

  render: (params) =>
    @user = User.find(params.id)
    @html @template @user
    if @user != null
      do @applyBindings

  save: (event) =>
    # TODO: make password optional
    unless @user.save()
      msg = @user.validate()
      return alert(msg)

  template: (item) ->
    binaries = null
    servers  = null
    if item != null
      binaries = item.binaries().all()
      servers  = item.servers().all()

    require('views/administration/users/form')
      binaries: binaries
      user:     item
      servers:  servers

module.exports = UserForm
