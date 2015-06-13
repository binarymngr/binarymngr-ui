Spine         = @Spine or require('spine')
BinaryVersion = require('models/binary_version')
Controller    = require('framework/core').Controller
Form          = require('framework/controllers').RecordForm

class BinaryVersionFormPage extends Controller
  constructor: ->
    super
    @form = new BinaryVersionForm
    @active @form.render
    @render()

  render: => @html @form.render()

class BinaryVersionForm extends Form
  model: BinaryVersion
  url  : '/binaries/versions'
  view : 'views/binaries/versions/form'

module?.exports      = BinaryVersionFormPage
module?.exports.Form = BinaryVersionForm
