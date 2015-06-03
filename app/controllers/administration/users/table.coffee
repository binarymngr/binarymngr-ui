Spine = @Spine or require 'spine'
User  = require 'models/user'
$     = Spine.$

class UsersTable extends Spine.Controller
  constructor: ->
    super

    @active @render
    User.bind 'refresh change', @render

  render: =>
    if @isActive
      @html @template User.all()
      @append new UsersTableAddModal  # FIXME

  template: (users) ->
    require('views/administration/users/table')
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
    if @user.save()
      $('body').removeClass('modal-open')  # FIXME
      $('body').find('.modal-backdrop.fade.in').remove()
    else
      msg = @user.validate()
      alert msg
