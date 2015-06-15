Spine          = @Spine or require('spine')
PrimaryNav     = require('controllers/components/primary_nav')
UtilityNav     = require('controllers/components/utility_nav')
ViewController = require('framework/core').ViewController

class Header extends ViewController
  attributes:
    role: 'navigation'
  className: 'navbar navbar-default navbar-pf'
  tag: 'nav'

  elements:
    '#spine-navbar': 'navbarEl'

  view: 'views/header'

  constructor: ->
    super
    @primaryNav = new PrimaryNav
    @utilityNav = new UtilityNav
    @primaryNav.bind 'activated', @utilityNav.deactivate
    @utilityNav.bind 'activated', @primaryNav.deactivate

  render: =>
    super
    @navbarEl.append @utilityNav.render()
    @navbarEl.append @primaryNav.render()
    @el

module?.exports = Header
