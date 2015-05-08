Spine  = @Spine or require('spine')
Binary = require('models/binary')
Server = require('models/server')
User   = require('models/user')

class UserForm extends Spine.Controller
  events:
    'click .can-cancel' : 'cancel'
    'click .can-destroy': 'destroy'
    'submit .item'      : 'save'

  modelVar: 'user'
  bindings:
    # '.item input[name="id"]'      : 'id'
    '.item input[name="email"]'   : 'email'
    '.item input[name="password"]': 'password'

  @extend Spine.Bindings

  constructor: ->
    super

    @user = null
    Binary.bind('refresh change destroy', @render)
    Server.bind('refresh change destroy', @render)
    User.bind('refresh change destroy', @render)

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
    if @user?
      do @applyBindings

  save: (event) =>
    event.preventDefault()

    # TODO: make password optional
    unless @user.save()
      msg = @user.validate()
      return alert(msg)

  template: (item) ->
    binaries = null
    servers  = null
    if item?
      binaries = item.binaries().all()
      servers  = item.servers().all()

    require('views/administration/users/form')
      binaries: binaries
      user:     item
      servers:  servers

module?.exports = UserForm
