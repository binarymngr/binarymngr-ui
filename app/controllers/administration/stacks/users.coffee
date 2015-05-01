Spine = @Spine or require('spine')
User  = require('models/user')

class AdministrationUserStack extends Spine.Controller
  constructor: ->
    super

    User.bind('refresh change', @render)
    do @render
    User.fetch()

  render: =>
    @html @template User.all()

  template: (items) ->
    require('views/administration/users')
      users: items

module.exports = AdministrationUserStack
