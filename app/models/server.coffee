Spine = require('spine')

class Server extends Spine.Model
  @configure 'Server', 'name', 'ipv4', 'owner_id'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @url: '/servers'

  validate: ->
    'Name is required' unless @name
    'IPv4 is required' unless @ipv4
    'Owner ID is required' unless @owner_id

module.exports = Server
