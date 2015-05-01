Spine  = @Spine or require('spine')
Binary = require('models/binary')
Server = require('models/server')

class User extends Spine.Model
  @configure 'User', 'email'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @hasMany 'binaries', Binary
  @hasMany 'servers', Server

  @url: '/users'

  validate: ->
    'Email is required' unless @email

module.exports = User
