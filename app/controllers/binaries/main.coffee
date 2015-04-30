Spine      = @Spine or require('spine')
Categories = require('controllers/binaries/stacks/categories')
Category   = require('controllers/binaries/stacks/category')
Single     = require('controllers/binaries/stacks/single')
Table      = require('controllers/binaries/stacks/table')

class BinariesMain extends Spine.Stack
  className: 'col-sm-9 col-md-10 col-sm-push-3 col-md-push-2 spine stack'

  controllers:
    categories: Categories
    category:   Category
    single:     Single
    table:      Table

  default: 'table'

  routes:
    '/binaries/categories/:id': 'category'
    '/binaries/categories'    : 'categories'
    '/binaries/:id'           : 'single'
    '/binaries'               : 'table'

module.exports = BinariesMain
