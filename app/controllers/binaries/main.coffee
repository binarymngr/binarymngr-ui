Spine      = @Spine or require('spine')
Categories = require('controllers/binaries/stacks/categories')
Category   = require('controllers/binaries/stacks/category')
Single     = require('controllers/binaries/stacks/single')
Table      = require('controllers/binaries/stacks/table')
Version    = require('controllers/binaries/stacks/version')
Versions   = require('controllers/binaries/stacks/versions')

class BinariesMain extends Spine.Stack
  className: 'col-sm-9 col-md-10 col-sm-push-3 col-md-push-2 spine stack'

  controllers:
    categories: Categories
    category:   Category
    single:     Single
    table:      Table
    version:    Version
    versions:   Versions

  default: 'table'

  routes:
    '/binaries/categories/:id': 'category'
    '/binaries/categories'    : 'categories'
    '/binaries/versions/:id'  : 'version'
    '/binaries/versions'      : 'versions'
    '/binaries/:id'           : 'single'
    '/binaries'               : 'table'

module.exports = BinariesMain
