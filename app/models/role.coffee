Spine = @Spine or require('spine')

class Role extends Spine.Model
  @configure 'Role', 'name', 'description'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @url: '/roles'

  validate: ->
    return 'Name is required' unless @name

module?.exports = Role
