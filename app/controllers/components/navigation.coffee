Spine = @Spine or require('spine')
$     = Spine.$

class NavigationComponent extends Spine.Controller
  elements:
    '.navbar-primary': 'primary_nav'
    '.navbar-utility': 'utility_nav'

  constructor: ->
    super

    # create a new router instance so we can listen to route changes
    # independent of the other app logic
    @router = Spine.Route.create()
    @router.add /^\/binaries(\/.*)?$/, =>
      @activateLink('/#/binaries')
    @router.add /^\/servers(\/.*)?$/, =>
      @activateLink('/#/servers')
    @router.add /^\/$/, =>
      @activateLink('/#/')

    @html require('views/components/navigation')
      rqst: Request.get()

  activateLink: (nav, link) =>
    # remove active class from all navs
    $(@primary_nav, @utility_nav).find('.active').removeClass('active')

    nav.find('a[href="'+ link +'"]').parent('li').addClass('active')

module?.exports = NavigationComponent
