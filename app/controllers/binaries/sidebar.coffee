Spine          = @Spine or require('spine')
BinaryCategory = require('models/binary_category')
LinkTitle      = require('controllers/components/sidebar').LinkTitle
NavBlock       = require('controllers/components/sidebar').NavBlock
List           = require('framework/controllers').List
ListItem       = require('framework/controllers').ListItem
Sidebar        = require('controllers/components/sidebar')
$              = Spine.$

# TODO: highlight current category
class BinariesSidebar extends Sidebar
  constructor: ->
    super
    @addItem new NavBlock(nav: new BinaryCategoriesNav, \
      title: new LinkTitle(link: '/binaries/categories', text: 'Categories'))
    @addItem new LinkTitle(link: '/binaries/versions', text: 'Versions')

class BinaryCategoryItem extends ListItem
  constructor: ->
    super
    @link = "/binaries/categories/#{@record.id}"

  render: => @html $("<a href='/##{@link}'>#{@record.name}</a>")

class BinaryCategoriesNav extends List
  className: 'items nav nav-pills nav-stacked'

  model : BinaryCategory
  record: BinaryCategoryItem

module?.exports                    = BinariesSidebar
module?.exports.CategoriesNav      = BinaryCategoriesNav
module?.exports.CategoriesNav.Item = BinaryCategoryItem
