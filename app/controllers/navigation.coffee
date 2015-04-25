Spine = require('spine')
$     = Spine.$

class Navigation extends Spine.Controller
  elements:
    'a': 'links'

  events:
    'click a': 'link_clicked'

  constructor: ->
    super

    @html require('views/partials/navigation')({})

  link_clicked: (event) ->
    @log event

module.exports = Navigation
