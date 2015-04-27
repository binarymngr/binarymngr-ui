Spine = require('spine')

class BinaryCategory extends Spine.Model
  @configure 'BinaryCategory', 'name', 'description'

  @extend Spine.Events
  @extend Spine.Model.Ajax

  @url: '/binaries/categories'

  validate: ->
    'Name is required' unless @name

module.exports = BinaryCategory
