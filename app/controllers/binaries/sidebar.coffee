Spine          = @Spine or require('spine')
BinaryCategory = require('models/binary_category')
Controllers    = require('framework/controllers')
List           = Controllers.List
ListItem       = Controllers.ListItem
Sidebar        = require('controllers/components/sidebar')
LinkTitle      = Sidebar.LinkTitle
NavBlock       = Sidebar.NavBlock
$              = Spine.$

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
    @router.add new RegExp("^#{@link}$"), @activate
    @router.add new RegExp("^(?!#{@link}$).*$"), @deactivate  # FIXME

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

  addOne: (record) =>
    item = super
    item.bind 'activated', => @trigger 'activated', @

module?.exports                    = BinariesSidebar
module?.exports.CategoriesNav      = BinaryCategoriesNav
module?.exports.CategoriesNav.Item = BinaryCategoryItem
