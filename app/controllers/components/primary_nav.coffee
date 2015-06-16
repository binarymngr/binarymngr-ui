Spine      = @Spine or require('spine')
Navigation = require('controllers/components/navigation')
Link       = Navigation.Link
$          = Spine.$

class PrimaryNav extends Navigation
  className: 'nav navbar-nav navbar-primary'

  constructor: ->
    super
    @addItem new Link(link: '/',         text: 'Dashboard')
    @addItem new Link(link: '/binaries', text: 'Binaries')
    @addItem new Link(link: '/servers',  text: 'Servers')

module?.exports = PrimaryNav
