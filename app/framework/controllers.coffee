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

  addAll: => @model.each @addOne

  addOne: (record) =>
    record = new @record(record: record)
    @items.append record.render()
    record

class List extends Collection
  className: 'items'
  tag: 'ul'

  addOne: (record) =>
    record = new @record(record: record)
    @append record.render()
    record

# TODO: DataTables
class Table extends Collection
  className: 'table-responsive'
  tag: 'div'

  constructor: ->
    super
    throw new Error('@columns is required') unless @columns

  render: =>
    return super if @view isnt Core.DUMMY_VIEW
    table = $('<table class="datatable table table-striped table-bordered"> \
                 <thead><tr></tr></thead> \
               </table>')
    for column in @columns
      table.find('tr').append $("<th>#{column}</th>")
    table.append $('<tbody class="items"></tbody>')
    @html table

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

module?.exports            = {}
# Collections
module?.exports.Collection = Collection
module?.exports.List       = List
module?.exports.Table      = Table
# Forms
module?.exports.Form       = Form
module?.exports.RecordForm = RecordForm
# Modals
module?.exports.Modal      = Modal
# Records
module?.exports.Record     = Record
module?.exports.ListItem   = ListItem
module?.exports.TableRow   = TableRow
