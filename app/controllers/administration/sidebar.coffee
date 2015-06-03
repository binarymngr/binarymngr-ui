Spine = @Spine or require 'spine'

class AdministrationSidebar extends Spine.Controller
  className: 'col-sm-3 col-md-2 col-sm-pull-9 col-md-pull-10 sidebar-pf sidebar-pf-left'

  elements:
    '.items': 'sections_nav'

  constructor: ->
    super

    # create a new router instance so we can listen to route changes
    # independent of the other app logic
    @router = Spine.Route.create()

    @router.add /^\/administration\/roles(\/.*)?$/, =>
      @activateLink('/#/administration/roles')
    @router.add /^\/administration\/users(\/.*)?$/, =>
      @activateLink('/#/administration/users')

    @html require('views/administration/sidebar')()

  activateLink: (link) ->
    # remove active class from all sections
    @sections_nav.find('.active').removeClass('active')
    # add active again to current one
    @sections_nav.find('a[href="'+link+'"]').parent('li').addClass('active')

module?.exports = AdministrationSidebar
