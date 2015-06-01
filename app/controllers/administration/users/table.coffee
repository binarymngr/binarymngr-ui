Spine   = @Spine or require 'spine'
Request = require 'lib/http/request'
User    = require 'models/user'
$       = Spine.$

class UsersTable extends Spine.Controller
  constructor: ->
    super

    User.bind 'refresh change', @render
    @render()

  render: =>
    @html @template User.all()
    @append new UsersTableAddModal  # FIXME: do not init a new one every time

  template: (users) ->
    require('views/administration/users/table')
      rqst: Request.get()
      users: users

module?.exports = UsersTable


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
    @render()

  render: =>
    @html require('views/administration/users/add-modal')()
    @applyBindings()

  save: (event) =>
    event.preventDefault()

    if @user.isValid() and User.save(@user)
      @user = new User
      @applyBindings()
      # FIXME: hide backdrop
      $('.modal-backdrop.fade.in').fadeOut 'fast', ->
        @.remove()
    else
      msg = @user.validate()
      return alert msg
