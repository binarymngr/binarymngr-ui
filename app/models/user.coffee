Spine  = @Spine or require('spine')
Server = require('models/server')

class User extends Spine.Model
  @configure 'User', 'email', 'password'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @hasMany 'binaries', 'models/binary', 'owner_id'  # 'models/binary' is a hack because it doesn't work with Binary
  @hasMany 'servers', Server, 'owner_id'

  @url: '/users'

  validate: ->
    return 'Email is required' unless @email
    return 'Password is required' unless @password

module?.exports = User
