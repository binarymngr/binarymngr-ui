Spine          = @Spine or require('spine')
BinaryCategory = require('models/binary_category')
LinkTitle      = require('controllers/components/sidebar').LinkTitle
NavBlock       = require('controllers/components/sidebar').NavBlock
List           = require('framework/controllers').List
ListItem       = require('framework/controllers').ListItem
Sidebar        = require('controllers/components/sidebar')
$              = Spine.$

# TODO: remove category highlight on categories/versions link click
# and on page leave
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
    @router = Spine.Route.create()
    @router.add @link, @activate

  activate: =>
    unless @isActive()
      @el.addClass 'active'
      @trigger 'activated', @

  deactivate: =>
    if @isActive()
      @el.removeClass 'active'
      @trigger 'deactivated', @

  isActive: => @el.hasClass 'active'
  render:   => @html $("<a href='/##{@link}'>#{@record.name}</a>")

class BinaryCategoriesNav extends List
  className: 'items nav nav-pills nav-stacked'

  model : BinaryCategory
  record: BinaryCategoryItem

  constructor: ->
    super
    @categories = []

  addOne: (record) =>
    item = super
    item.bind 'activated', => @trigger 'activated', @
    item.bind 'activated', @itemActivated
    @bind 'deactivated', item.deactivate
    item.record.bind 'destroy', => _.remove(@categories, item)  # cleanup
    @categories.push item

  itemActivated: (activated) =>
    $.each @categories, (i, cat) -> cat.deactivate() unless cat is activated

module?.exports                    = BinariesSidebar
module?.exports.CategoriesNav      = BinaryCategoriesNav
module?.exports.CategoriesNav.Item = BinaryCategoryItem
