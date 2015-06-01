Spine    = @Spine or require 'spine'
Binary   = require 'models/binary'
Category = require 'models/binary_category'
Message  = require 'models/message'
Role     = require 'models/role'
Server   = require 'models/server'
User     = require 'models/user'
Version  = require 'models/binary_version'

class DashboardMain extends Spine.Controller
  className: 'col-sm-8 col-md-9'
  events:
    'click .spine-refresh': 'refresh'

  constructor: ->
    super

    @html require('views/dashboard/main')()

  refresh: ->
    Binary.fetch()
    Category.fetch()
    Message.fetch()
    Role.fetch()
    Server.fetch()
    User.fetch()
    Version.fetch()

module?.exports = DashboardMain
