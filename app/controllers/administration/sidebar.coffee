Spine    = @Spine or require('spine')
Sidebar  = require('controllers/components/sidebar')
Nav      = Sidebar.Nav
NavBlock = Sidebar.NavBlock
Title    = Sidebar.Title
$        = Spine.$

class AdministrationSidebar extends Sidebar
  constructor: ->
    super

    sections = new Nav
    sections.addItem new Nav.Item(link: '/administration/roles', text: 'Roles')
    sections.addItem new Nav.Item(link: '/administration/users', text: 'Users')
    @addItem new NavBlock(nav: sections, title: new Title(text: 'Sections'))

module?.exports = AdministrationSidebar
