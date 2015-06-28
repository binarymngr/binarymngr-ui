Spine          = @Spine or require('spine')
BinariesTable  = require('controllers/binaries/page_table').Table
BinaryCategory = require('models/binary_category')
Controller     = require('framework/core').Controller
Form           = require('framework/controllers').RecordForm
Tabs           = require('framework/controllers').Tabs
$              = Spine.$

class BinaryCategoryFormPage extends Controller
  constructor: ->
    super

    @form = new BinaryCategoryForm
    @tabs = new Tabs.Nav
    @tabsContainer = new Tabs.Container

    @binariesTab = new Tabs.Tab(name: 'binaries')
    @binariesTable = new CategoryBinariesTable
    @tabs.addItem new Tabs.Nav.Item(tab: @binariesTab, text: 'Binaries')
    @tabsContainer.addItem @binariesTab


    @active @form.render
    @active @binariesTable.render
    @active _.first(@tabs.items).activate

    @render()

  render: =>
    @html @form.render()
    @append $('<hr/>')
    @append @tabs.render()
    @binariesTab.append @binariesTable.render()
    @append @tabsContainer.render()
    _.first(@tabs.items).activate()

class BinaryCategoryForm extends Form
  model: BinaryCategory
  url  : '/binaries/categories'
  view : 'views/binaries/categories/form'

class CategoryBinariesTable extends BinariesTable
  addAll: -> # NOP

  render: (params) =>
    @el.empty()
    category = BinaryCategory.find(params.id) if params?.id?
    if category
      super
      @addOne(c) for c in category.binaries()
    @el

module?.exports               = BinaryCategoryFormPage
module?.exports.Form          = BinaryCategoryForm
module?.exports.BinariesTable = CategoryBinariesTable
