Spine = @Spine or require('spine')

class BinaryCategory extends Spine.Model
  @extend Spine.Events
  @extend Spine.Model.Ajax

  @configure 'BinaryCategory', 'name', 'description'
  @url: '/binaries/categories'

  validate: ->
    'Name is required' unless @name

module.exports = BinaryCategory
