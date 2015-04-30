Spine = @Spine or require('spine')

class DashboardMain extends Spine.Controller
  className: 'col-sm-8 col-md-9'

  constructor: ->
    super
    @html require('views/dashboard/main')()

module.exports = DashboardMain
