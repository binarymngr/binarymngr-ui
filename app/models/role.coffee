Spine = require('spine')

class Role extends Spine.Model
  @configure 'Role', 'name', 'description'
  @extend Spine.Model.Ajax

  validate: ->
    "Name is required" unless @name
    "Description is required" unless @description

module.exports = Role
