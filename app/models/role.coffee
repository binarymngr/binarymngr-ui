Spine = require('spine')

class Role extends Spine.Model
  @configure 'Role', 'name', 'description'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @url: '/roles'

  validate: ->
    'Name is required' unless @name
    'Description is required' unless @description

module.exports = Role
