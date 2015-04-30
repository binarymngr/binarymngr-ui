Spine = @Spine or require('spine')
User  = require('models/user')

class AdministrationUserStack extends Spine.Controller
  constructor: ->
    super

    User.fetch()
    User.bind('refresh change', @render)

  render: =>
    @html @template User.all()

  template: (items) ->
    require('views/administration/users')
      users: items

module.exports = AdministrationUserStack
