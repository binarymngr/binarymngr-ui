Spine = @Spine or require('spine')
Role  = require('models/role')

class RoleForm extends Spine.Controller
  events:
    'click .can-cancel' : 'cancel'
    'click .can-destroy': 'destroy'
    'submit .item'      : 'save'

  modelVar: 'role'
  bindings:
    # '.item input[name="id"]'            : 'id'
    '.item input[name="name"]'          : 'name'
    '.item textarea[name="description"]': 'description'

  @extend Spine.Bindings

  constructor: ->
    super

    @role = null
    Role.bind('refresh change', @render)

    @routes
      '/administration/roles/:id': (params) ->
        @render params

  cancel: (event) =>
    @navigate('/administration/roles')

  destroy: (event) =>
    if @role.destroy()
      @navigate('/administration/roles')
    else
      return alert('Something went wrong')

  render: (params) =>
    @role = Role.find(params.id)
    @html @template @role
    if @role != null
      do @applyBindings

  save: (event) =>
    event.preventDefault()

    unless @role.save()
      msg = @role.validate()
      return alert(msg)

  template: (item) ->
    require('views/administration/roles/form')
      role: item

module.exports = RoleForm
