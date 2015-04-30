Spine = @Spine or require('spine')

class DashboardSidebar extends Spine.Controller
  className: 'col-sm-4 col-md-3 sidebar-pf sidebar-pf-right'

  constructor: ->
    super
    @html require('views/dashboard/sidebar')()

module.exports = DashboardSidebar
