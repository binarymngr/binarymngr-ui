Spine = @Spine or require('spine')
Role  = require('models/role')

class AdministrationRolesStack extends Spine.Controller
  constructor: ->
    super

    Role.fetch()
    Role.bind('refresh change', @render)

  render: =>
    @html @template Role.all()

  template: (items) ->
    require('views/administration/roles')
      roles: items

module.exports = AdministrationRolesStack
