Spine      = @Spine or require('spine')
Controller = require('framework/core').Controller
Form       = require('framework/controllers').RecordForm
Role       = require('models/role')
Tabs       = require('framework/controllers').Tabs
User       = require('models/user')
UsersTable = require('controllers/administration/users/page_table').Table
$          = Spine.$

class RoleFormPage extends Controller
  constructor: ->
    super

    @form = new RoleForm
    @tabs = new Tabs.Nav
    @tabsContainer = new Tabs.Container

    @usersTab = new Tabs.Tab(name: 'users')
    @usersTable = new RoleUsersTable
    @tabs.addItem new Tabs.Nav.Item(tab: @usersTab, text: 'Users')
    @tabsContainer.addItem @usersTab

    @active @form.render
    @active @usersTable.render
    @active _.first(@tabs.items).activate

    @render()

  render: =>
    @html @form.render()
    @append $('<hr/>')
    @append @tabs.render()
    @usersTab.append @usersTable.render()
    @append @tabsContainer.render()
    _.first(@tabs.items).activate()

class RoleForm extends Form
  model: Role
  url  : '/administration/roles'
  view : 'views/administration/roles/form'

class RoleUsersTable extends UsersTable
  addAll: -> # NOP

  render: (params) =>
    @el.empty()
    role = Role.find(params.id) if params?.id?
    if role
      super
      @addOne(u) for u in role.users()
    @el

module?.exports            = RoleFormPage
module?.exports.Form       = RoleForm
module?.exports.UsersTable = RoleUsersTable
