Spine   = @Spine or require('spine')
Message = require('models/message')

class DashboardSidebar extends Spine.Controller
  className: 'col-sm-4 col-md-3 sidebar-pf sidebar-pf-right'

  constructor: ->
    super

    Message.bind 'refresh change', @render

  render: =>
    @html @template Message.all()

  template: (items) ->
    require('views/dashboard/sidebar')
      messages: items

module?.exports = DashboardSidebar
