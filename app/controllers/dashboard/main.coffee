Spine          = @Spine or require('spine')
Binary         = require('models/binary')
BinaryCategory = require('models/binary_category')
BinaryVersion  = require('models/binary_version')
Message        = require('models/message')
Role           = require('models/role')
Server         = require('models/server')
User           = require('models/user')
ViewController = require('framework/core').ViewController

class DashboardMain extends ViewController
  className: 'col-sm-8 col-md-9'

  elements:
    '.spine-refresh span': 'refreshIcon'
  events:
    'click .spine-refresh': 'refresh'

  refreshClasses: 'pficon pficon-refresh'
  spinnerClasses: 'spinner spinner-xs spinner-inline'

  view: 'views/dashboard/main'

  refresh: =>
    @refreshIcon.removeClass @refreshClasses
    @refreshIcon.addClass @spinnerClasses
    Binary.fetch()
    BinaryCategory.fetch()
    BinaryVersion.fetch()
    Message.fetch()
    Role.fetch()
    Server.fetch()
    User.fetch()
    @delay ->
      @refreshIcon.addClass @refreshClasses
      @refreshIcon.removeClass @spinnerClasses
    , 1000  # TODO: until all fetch are done


module?.exports = DashboardMain
