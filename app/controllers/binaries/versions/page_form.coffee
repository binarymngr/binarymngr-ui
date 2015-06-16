Spine         = @Spine or require('spine')
BinaryVersion = require('models/binary_version')
Controller    = require('framework/core').Controller
Form          = require('framework/controllers').RecordForm
ServersTable  = require('controllers/servers/page_table').Table
Tabs          = require('controllers/components/tabs')

class BinaryVersionFormPage extends Controller
  constructor: ->
    super

    @form = new BinaryVersionForm
    @tabs = new Tabs.Nav
    @tabsContainer = new Tabs.Container

    @serversTab = new Tabs.Tab(name: 'servers')
    @serversTable = new BinaryVersionServersTable
    @tabs.addItem new Tabs.Nav.Item(tab: @serversTab, text: 'Installed on')
    @tabsContainer.addItem @serversTab

    @active @form.render
    @active @serversTable.render

    _.first(@tabs.items).activate()
    @render()

  render: =>
    @html @form.render()
    @append $('<hr/>')
    @append @tabs.render()
    @serversTab.append @serversTable.render()
    @append @tabsContainer.render()

class BinaryVersionForm extends Form
  model: BinaryVersion
  url  : '/binaries/versions'
  view : 'views/binaries/versions/form'

class BinaryVersionServersTable extends ServersTable
  addAll: -> # NOP

  render: (params) =>
    @el.empty()
    version = BinaryVersion.find(params.id) if params?.id?
    if version
      super
      @addOne(s) for s in version.getServers()
    @el

module?.exports              = BinaryVersionFormPage
module?.exports.Form         = BinaryVersionForm
module?.exports.ServersTable = BinaryVersionServersTable
