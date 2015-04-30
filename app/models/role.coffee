Spine = @Spine or require('spine')

class Role extends Spine.Model
  @extend Spine.Events
  @extend Spine.Model.Ajax

  @configure 'Role', 'name', 'description'
  @url: '/roles'

  validate: ->
    'Name is required' unless @name
    'Description is required' unless @description

module.exports = Role
