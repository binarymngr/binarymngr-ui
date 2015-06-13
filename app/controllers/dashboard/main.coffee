Spine          = @Spine or require('spine')
ViewController = require('framework/core').ViewController

class DashboardMain extends ViewController
  className: 'col-sm-8 col-md-9'
  view: 'views/dashboard/main'

module?.exports = DashboardMain
