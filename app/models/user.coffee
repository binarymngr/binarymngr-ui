Spine = @Spine or require('spine')

class User extends Spine.Model
  @extend Spine.Events
  @extend Spine.Model.Ajax

  @configure 'User', 'email'
  @url: '/users'

  validate: ->
    'Email is required' unless @email

module.exports = User
