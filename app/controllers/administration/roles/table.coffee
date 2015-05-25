Spine   = @Spine or require('spine')
Role    = require('models/role')
Request = require('http/request')
$       = Spine.$

class RolesTable extends Spine.Controller
  constructor: ->
    super

    Role.bind 'refresh change', @render
    @render()

  render: =>
    @html @template Role.all()
    @append new RolesTableAddModal  # TODO: do not init a new one every time

  template: (items) ->
    require('views/administration/roles/table')
      roles: items
      rqst: Request.get()

module?.exports = RolesTable


class RolesTableAddModal extends Spine.Controller
  events:
    'submit .item': 'save'

  modelVar: 'role'
  bindings:
    '.item input[name="name"]'          : 'name'
    '.item textarea[name="description"]': 'description'

  @extend Spine.Bindings

  constructor: ->
    super

    @role = new Role
    @render()

  render: =>
    @html require('views/administration/roles/add-modal')()
    @applyBindings()

  save: (event) =>
    event.preventDefault()

    if @role.notifySave(@role.save())
      @role = new Role
      @applyBindings()
      # FIXME: hide backdrop
      $('.modal-backdrop.fade.in').fadeOut 'fast', ->
        this.remove()
    else
      msg = @role.validate()
      return alert msg
