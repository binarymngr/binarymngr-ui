Spine = require('spine')
User  = require('models/user')

class AdministrationUser extends Spine.Controller
  elements:
    '.items': 'items'

  constructor: ->
    super

    User.fetch()
    User.bind('refresh change', @render)

  render: =>
    @html @template User.all()

  template: (items) ->
    require('views/administration/users')
      users: items

module.exports = AdministrationUser
