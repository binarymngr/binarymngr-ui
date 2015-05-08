Spine      = @Spine or require('spine')
Binaries   = require('controllers/binaries/table')
Binary     = require('controllers/binaries/form')
Categories = require('controllers/binaries/categories/table')
Category   = require('controllers/binaries/categories/form')
Version    = require('controllers/binaries/versions/form')
Versions   = require('controllers/binaries/versions/table')

class BinariesMain extends Spine.Stack
  className: 'col-sm-9 col-md-10 col-sm-push-3 col-md-push-2 spine stack'

  controllers:
    binaries:   Binaries
    binary:     Binary
    categories: Categories
    category:   Category
    version:    Version
    versions:   Versions

  default: 'binaries'

  routes:
    '/binaries/categories/:id': 'category'
    '/binaries/categories'    : 'categories'
    '/binaries/versions/:id'  : 'version'
    '/binaries/versions'      : 'versions'
    '/binaries/:id'           : 'binary'
    '/binaries'               : 'binaries'

module?.exports = BinariesMain
