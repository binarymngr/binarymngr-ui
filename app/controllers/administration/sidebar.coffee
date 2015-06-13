Spine    = @Spine or require('spine')
Nav      = require('controllers/components/sidebar').NavBlock.Nav
NavBlock = require('controllers/components/sidebar').NavBlock
NavItem  = require('controllers/components/sidebar').NavBlock.Nav.Item
Sidebar  = require('controllers/components/sidebar')
Title    = require('controllers/components/sidebar').Title
$        = Spine.$

class AdministrationSidebar extends Sidebar
  constructor: ->
    super
    # sections navigation
    nav = new Nav
    nav.addItem new NavItem(link: '/administration/roles', text: 'Roles')
    nav.addItem new NavItem(link: '/administration/users', text: 'Users')
    @addItem new NavBlock(nav: nav, title: new Title(text: 'Sections'))

module?.exports = AdministrationSidebar
