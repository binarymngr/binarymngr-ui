Spine   = @Spine or require('spine')
Binary  = require('models/binary')
Server  = require('models/server')
User    = require('models/user')
Version = require('models/binary_version')

class BinaryVersionForm extends Spine.Controller
  events:
    'click .spine-cancel' : 'cancel'
    'click .spine-destroy': 'destroy'
    'submit .item'        : 'save'

  modelVar: 'version'
  bindings:
    # '.item input[name="id"]'        : 'id'
    '.item input[name="identifier"]': 'identifier'
    '.item textarea[name="note"]'   : 'note'
    '.item input[name="eol"]'       : 'eol'

  @extend Spine.Bindings

  constructor: ->
    super

    @version = null
    Binary.bind 'refresh', @render
    Server.bind 'refresh', @render
    User.bind 'refresh', @render
    Version.bind 'refresh change', @render

    @routes
      '/binaries/versions/:id': (params) ->
        @render params

  cancel: (event) =>
    @navigate '/binaries/versions'

  destroy: (event) =>
    if @version.notifyDestroy()
      @navigate '/binaries/versions'

  render: (params) =>
    @version = Version.find params.id if params?.id?
    @html @template @version
    @applyBindings() if @version?

  save: (event) =>
    event.preventDefault()

    unless @version.notifySave(@version.save())
      msg = @version.validate()
      return alert msg

  template: (item) ->
    binary  = null
    binary  = item.binary() if item?
    servers = null
    servers = item.getServers() if item?

    require('views/binaries/versions/form')
      binary: binary
      servers: servers
      version: item

module?.exports = BinaryVersionForm
