Spine = @Spine or require('spine')
User  = require('models/user')

class UsersTable extends Spine.Controller
  constructor: ->
    super

    User.bind('refresh change', @render)
    do @render

  render: =>
    @html @template User.all()
    @append new UsersTableAddModal  # TODO: do not init a new one every time

  template: (items) ->
    require('views/administration/users/table')
      users: items

module.exports = UsersTable


class UsersTableAddModal extends Spine.Controller
  events:
    'submit .item': 'save'

  modelVar: 'user'
  bindings:
    '.item input[name="email"]'   : 'email'
    '.item input[name="password"]': 'password'

  @extend Spine.Bindings

  constructor: ->
    super

    @user = new User
    do @render

  render: =>
    @html require('views/administration/users/add-modal')()
    do @applyBindings

  save: (event) =>
    event.preventDefault()

    if @user.save()
      @user = new User
      do @applyBindings
      # TODO: fix hide backdrop
      $('.modal-backdrop.fade.in').fadeOut('fast', ->
        this.remove()
      )
    else
      msg = @user.validate()
      return alert(msg)
