Spine          = @Spine or require('spine')
BinariesTable  = require('controllers/binaries/page_table').Table
BinaryCategory = require('models/binary_category')
Controller     = require('framework/core').Controller
Form           = require('framework/controllers').RecordForm
$              = Spine.$

class BinaryCategoryFormPage extends Controller
  constructor: ->
    super
    @form = new BinaryCategoryForm
    @binariesTable = new CategoryBinariesTable
    @active @form.render
    @active @binariesTable.render
    @render()

  render: =>
    @html @form.render()
    @append @binariesTable.render()

class BinaryCategoryForm extends Form
  model: BinaryCategory
  url  : '/binaries/categories'
  view : 'views/binaries/categories/form'

class CategoryBinariesTable extends BinariesTable
  constructor: ->
    super
    @heading = $('<hr><h2>Binaries</h2>')

  addAll: -> # NOP

  render: (params) =>
    @heading.remove()
    @el.empty()
    category = BinaryCategory.find(params.id) if params?.id?
    if category
      super
      @heading.insertBefore @el
      @addOne(c) for c in category.getBinaries()
    @el

module?.exports               = BinaryCategoryFormPage
module?.exports.Form          = BinaryCategoryForm
module?.exports.BinariesTable = CategoryBinariesTable
