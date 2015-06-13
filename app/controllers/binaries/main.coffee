Spine      = @Spine or require('spine')
Stack      = require('framework/managers').Stack
Binaries   = require('controllers/binaries/page_table')
Binary     = require('controllers/binaries/page_form')
Categories = require('controllers/binaries/categories/page_table')
Category   = require('controllers/binaries/categories/page_form')
Version    = require('controllers/binaries/versions/page_form')
Versions   = require('controllers/binaries/versions/page_table')

class BinariesStack extends Stack
  className: 'spine stack col-sm-9 col-md-10 col-sm-push-3 col-md-push-2'

  controllers:
    binaries  : Binaries
    binary    : Binary
    categories: Categories
    category  : Category
    version   : Version
    versions  : Versions

  default: 'binaries'

  routes:
    '/binaries/versions/:id'  : 'version'
    '/binaries/versions'      : 'versions'
    '/binaries/categories/:id': 'category'
    '/binaries/categories'    : 'categories'
    '/binaries/:id'           : 'binary'
    '/binaries'               : 'binaries'

module?.exports = BinariesStack
