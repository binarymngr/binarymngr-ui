Spine               = @Spine or require('spine')
BinaryVersionsTable = require('controllers/binaries/versions/page_table').Table
Controller          = require('framework/core').Controller
Form                = require('framework/controllers').RecordForm
Server              = require('models/server')
$                   = Spine.$

class ServerFormPage extends Controller
  className: 'col-xs-12'

  constructor: ->
    super
    @form = new ServerForm
    @binaryVersionsTable = new ServerBinaryVersionsTable
    @active @form.render
    @active @binaryVersionsTable.render
    @render()

  render: =>
    @html @form.render
    @append @binaryVersionsTable.render

class ServerForm extends Form
  model: Server
  url  : '/servers'
  view : 'views/servers/form'

class ServerBinaryVersionsTable extends BinaryVersionsTable
  constructor: ->
    super
    @heading = $('<hr><h2>Installed Binaries</h2>')

  addAll: -> # NOP

  render: (params) =>
    @heading.remove()
    @el.empty()
    server = Server.find(params.id) if params?.id?
    if server
      super
      @heading.insertBefore @el
      $.each server.getBinaryVersions(), (i, version) => @addOne version
    @el

module?.exports                     = ServerFormPage
module?.exports.Form                = ServerForm
module?.exports.BinaryVersionsTable = ServerBinaryVersionsTable
