Spine   = @Spine or require 'spine'
Message = require 'models/message'

class DashboardSidebar extends Spine.Controller
  className: 'col-sm-4 col-md-3 sidebar-pf sidebar-pf-right'

  events:
    'click .spine-clear-messages': 'destroyMessages'

  constructor: ->
    super

    Message.bind 'refresh change', @render
    @render()

  destroyMessages: -> Message.destroyAll()

  render: => @html @template Message.all()

  template: (messages) ->
    require('views/dashboard/sidebar')
      messages: messages

module?.exports = DashboardSidebar
