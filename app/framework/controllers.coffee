Spine = @Spine or require('spine')
Core = require('framework/core')
$    = Spine.$

# Collections
class Collection extends Core.ViewController
  elements:
    '.items': 'items'

  constructor: ->
    super
    throw new Error('@record is required') unless @record
    throw new Error('@model is required') unless @model
    @model.bind 'create', @addOne
    @model.bind 'refresh', @addAll

  addAll: =>
    @items.empty()
    @model.each @addOne

  addOne: (record) =>
    record = new @record(record: record)
    @items.append record.render()
    record

class List extends Collection
  className: 'items'
  tag: 'ul'

  addAll: =>
    @el.empty()
    @model.each @addOne

  addOne: (record) =>
    record = new @record(record: record)
    @append record.render()
    record

# TODO: pager or even better: DataTables
class Table extends Collection
  className: 'table-responsive'
  tag: 'div'

  constructor: ->
    super
    throw new Error('@columns is required') unless @columns

  addOne: (record) =>
    row = super
    record?.bind 'destroy', @update
    record?.bind 'update', @update
    @update()
    row

  render: =>
    return super if @view isnt Core.DUMMY_VIEW
    @table = $('<table class="table table-striped table-bordered tablesorter"> \
                 <thead><tr></tr></thead> \
               </table>')
    for column in @columns
      @table.find('tr').append $("<th data-placeholder='...'>#{column}</th>")
    @table.append $('<tbody class="items"></tbody>')
    @table.tablesorter
      delayInit: true  # better performance?
      theme: ''
      widgets: ['filter']
      widgetOptions:
        filter_hideEmpty: true
        filter_liveSearch: true
        filter_searchDelay: 25
      widthFixed: true
    @html @table

  update: => @table?.trigger 'updateRows'

# Forms
class Form extends Core.ViewController
  className: 'form form-horizontal'
  tag: 'form'

  events:
    'submit': 'submit'

  constructor: ->
    super
    @action = '#' unless @action

  submit: (event) => @trigger 'submitted', @, event

class RecordForm extends Form
  events:
    'click .spine-cancel' : 'cancel'
    'click .spine-destroy': 'destroy'

  constructor: ->
    super
    throw new Error('@model is required') unless @model
    @record  = null
    # callbacks
    @error   = ((record) ->
      msg = record.validate()
      alert msg
    ) unless @error
    @success = (->) unless @success

  cancel:  => @navigate @url
  destroy: => @navigate @url if @record.destroy()

  render: (record) =>
    @record = @model.find(record.id) if record?.id?
    @record.one('change', @render) if @record
    @html @template @record

  submit: (event) =>
    event.preventDefault()
    super
    if @record.fromForm(@el).save()
      @success @record
      @trigger 'success', @record
    else
      @error @record
      @trigger 'error', @record

  template: (record) => require(@view)(item: record)

# Modals
# TODO: BS events
class Modal extends Core.ViewController
  attributes:
    'aria-hidden': true
    'role'       : 'dialog'
    'tabindex'   : -1
  className: 'modal fade'

  constructor: ->
    super
    throw new Error('@content is required') unless @content
    throw new Error('@id is required') unless @id
    throw new Error('@title is required') unless @title
    @attributes.id = @id
    @el.attr 'id', @id

  render: =>
    @html $("<div class='modal-dialog'><div class='modal-content'>\
        <div class='modal-header'>\
          <button class='close' type='button' data-dismiss='modal' aria-hidden='true'>\
            <span class='pficon pficon-close'></span>
          </button>
          <h4 class='modal-title'>#{@title}</h4>
        </div>\
      </div></div>")
    @$('h4.modal-title').after @content.render()
    @el

# Navigations
class Navigation extends Core.Controller
  className: 'nav navbar-nav'
  tag: 'ul'

  constructor: ->
    super
    @items = []

  addItem: (item) =>
    item.bind 'activated', => @trigger 'activated', @
    item.bind 'activated', @itemActivated
    @bind 'deactivated', item.deactivate
    @items.push item

  deactivate: => @trigger 'deactivated', @

  itemActivated: (activated) =>
    for item in @items
      item.deactivate() unless item is activated

  render: =>
    @el.empty()
    @append(item.render()) for item in @items

class NavItem extends Core.Controller
  tag: 'li'

  activate: =>
    unless @isActive()
      @el.addClass 'active'
      @trigger 'activated', @

  deactivate: =>
    if @isActive()
      @el.removeClass 'active'
      @trigger 'deactivated', @

  isActive: => @el.hasClass 'active'

class Link extends NavItem
  events:
    'click > a' : 'clicked'

  constructor: ->
    super
    throw new Error('@link is required') unless @link
    throw new Error('@text is required') unless @text
    @external = false unless @external
    @router = Spine.Route.create()
    @router.add new RegExp("^#{@link}(\\/[^\\/])*$"), @activate

  clicked: (event) => @trigger 'clicked', @

  render: =>
    if @external
      @html $("<a href='#{@link}'>#{@text}</a>")
    else @html $("<a href='/##{@link}'>#{@text}</a>")

# Records
class Record extends Core.ViewController
  className: 'item'

  constructor: ->
    super
    throw new Error('@record is required') unless @record
    @record.bind 'update', @render
    @record.bind 'destroy', @remove

  remove: => @el.remove()

  render: (record) =>
    @record = record if record
    @html @template @record

  template: (record) => require(@view)(item: @record)

class ListItem extends Record
  tag: 'li'

class TableRow extends Record
  tag: 'tr'

# Tabs
class TabNav extends Navigation
  attributes:
    role: 'tablist'
  className: 'nav nav-tabs'

class TabNavItem extends NavItem
  attributes:
    role: 'presentation'

  events:
    'click > a' : 'activate'

  constructor: ->
    super
    throw new Error('@tab is required') unless @tab
    throw new Error('@text is required') unless @text
    @bind 'activated', @tab.activate
    @bind 'deactivated', @tab.deactivate

  render: => @html $("<a href='##{@tab.name}' aria-controls='#{@tab.name}' \
                      role='tab' data-toggle='tab'>#{@text}</a>")

class TabContainer extends Core.Controller
  className: 'tab-content'

  constructor: ->
    super
    @items = []

  addItem: (item) =>
    item.bind 'activated', => @trigger 'activated', @
    item.bind 'activated', @itemActivated
    @bind 'deactivated', item.deactivate
    @items.push item

  deactivate: => @trigger 'deactivated', @

  itemActivated: (activated) =>
    for item in @items
      item.deactivate() unless item is activated

  render: =>
    @el.empty()
    @append(item.render()) for item in @items

class Tab extends Core.Controller
  attributes:
    role: 'tabpanel'
  className: 'tab-pane'

  constructor: ->
    super
    throw new Error('@name is required') unless @name
    @attributes.id = @name
    @el.attr 'id', @name

  activate: =>
    unless @isActive()
      @el.addClass 'active'
      @trigger 'activated', @

  deactivate: =>
    if @isActive()
      @el.removeClass 'active'
      @trigger 'deactivated', @

  isActive: => @el.hasClass 'active'

module?.exports                 = {}
# Collections
module?.exports.Collection      = Collection
module?.exports.List            = List
module?.exports.Table           = Table
# Forms
module?.exports.Form            = Form
module?.exports.RecordForm      = RecordForm
# Modals
module?.exports.Modal           = Modal
# Navigations
module?.exports.Navigation      = Navigation
module?.exports.Navigation.Item = NavItem
module?.exports.Navigation.Link = Link
# Records
module?.exports.Record          = Record
module?.exports.ListItem        = ListItem
module?.exports.TableRow        = TableRow
# Tabs
module?.exports.Tabs            = {}
module?.exports.Tabs.Nav        = TabNav
module?.exports.Tabs.Nav.Item   = TabNavItem
module?.exports.Tabs.Container  = TabContainer
module?.exports.Tabs.Tab        = Tab
