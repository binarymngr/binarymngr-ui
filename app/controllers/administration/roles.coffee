Spine = require('spine')
Role  = require('models/role')

class AdministrationRoles extends Spine.Controller
  elements:
    '.items': 'items'

  constructor: ->
    super

    Role.fetch()
    Role.bind('refresh change', @render)

  render: =>
    @html @template Role.all()

  template: (items) ->
    require('views/administration/roles')
      roles: items

module.exports = AdministrationRoles
