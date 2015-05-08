Spine = @Spine or require('spine')
User  = require('models/user')

class Server extends Spine.Model
  @configure 'Server', 'name', 'ipv4', 'owner_id'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @belongsTo 'owner', User

  @url: '/servers'

  validate: ->
    return 'Name is required' unless @name
    return 'IPv4 address is required' unless @ipv4

module?.exports = Server
