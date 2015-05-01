Spine = @Spine or require('spine')

class User extends Spine.Model
  @configure 'User', 'email'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @url: '/users'

  validate: ->
    'Email is required' unless @email

module.exports = User
