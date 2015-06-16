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
  view: 'views/dashboard/main'

module?.exports = DashboardMain
