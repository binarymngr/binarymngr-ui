Spine         = @Spine or require('spine')
BinaryVersion = require('models/binary_version')
Controller    = require('framework/core').Controller
Form          = require('framework/controllers').RecordForm
ServersTable  = require('controllers/servers/page_table').Table

class BinaryVersionFormPage extends Controller
  constructor: ->
    super
    @form = new BinaryVersionForm
    @serversTable = new BinaryVersionServersTable
    @active @form.render
    @active @serversTable.render
    @render()

  render: =>
    @html @form.render()
    @append @serversTable.render()

class BinaryVersionForm extends Form
  model: BinaryVersion
  url  : '/binaries/versions'
  view : 'views/binaries/versions/form'

class BinaryVersionServersTable extends ServersTable
  constructor: ->
    super
    @heading = $('<hr><h2>Installed on</h2>')

  addAll: -> # NOP

  render: (params) =>
    @heading.remove()
    @el.empty()
    version = BinaryVersion.find(params.id) if params?.id?
    if version
      super
      @heading.insertBefore @el
      @addOne(s) for s in version.getServers()
    @el

module?.exports              = BinaryVersionFormPage
module?.exports.Form         = BinaryVersionForm
module?.exports.ServersTable = BinaryVersionServersTable
