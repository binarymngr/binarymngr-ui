Spine  = @Spine or require('spine')
Server = require('models/server')

class User extends Spine.Model
  @configure 'User', 'email'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @hasMany 'binaries', 'models/binary', 'owner_id'  # 'models/binary' is a hack because it doesn't work with Binary
  @hasMany 'servers', Server, 'owner_id'

  @url: '/users'

  validate: ->
    'Email is required' unless @email

module.exports = User
