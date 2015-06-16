Spine          = @Spine or require('spine')
Controller     = require('framework/core').Controller
Controllers    = require('framework/controllers')
List           = Controllers.List
ListItem       = Controllers.ListItem
Message        = require('models/message')
Sidebar        = require('controllers/components/sidebar')
SidebarElement = Sidebar.Element
Title          = Sidebar.Title
$              = Spine.$

class DashboardSidebar extends Sidebar
  className: 'col-sm-4 col-md-3 sidebar-pf sidebar-pf-right'

  constructor: ->
    super
    @addItem new MessagesListHeader
    @addItem new MessagesList
    @addItem new MessagesLink

class MessagesListHeader extends Title
  className: 'sidebar-header sidebar-header-bleed-left sidebar-header-bleed-right'

  events:
    'click .spine-clear' : 'clearMessages'

  constructor: ->
    @text = 'Latest Messages'
    super
    Message.bind 'refresh change', @render

  clearMessages: -> Message.each (msg) -> msg.destroy()  # Message.destroyAll()

  render: =>
    super
    if Message.count() isnt 0
      @prepend $('<div class="actions pull-right spine-clear"> \
                  <a href="#">Clear Messages</a></div>')
    @el

class MessagesListItem extends ListItem
  className: 'list-group-item'
  view: 'views/dashboard/messages_list_item'

class MessagesList extends List
  className: 'items list-group'

  model : Message
  record: MessagesListItem

class MessagesLink extends SidebarElement
  tag: 'p'

  constructor: ->
    super
    Message.bind 'refresh change', @render

  render: =>
    if Message.count() is 0
      @el.hide()
    else
      @html $('<a href="/#/messages">See all messages</a>')
      @el.show()
    @el

module?.exports                     = DashboardSidebar
module?.exports.MessagesLink        = MessagesLink
module?.exports.MessagesList        = MessagesList
module?.exports.MessagesList.Header = MessagesListHeader
module?.exports.MessagesList.Item   = MessagesListItem
