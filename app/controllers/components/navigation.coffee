Spine = @Spine or require('spine')

class NavigationComponent extends Spine.Controller
  @ACTIVE_CLASS: 'active'
  @ROUTE_PREFIX: '/#'

  elements:
    '.navbar-primary': 'primary_nav'
    '.navbar-utility': 'utility_nav'

  constructor: ->
    super

    @html require('views/components/navigation')()
    Spine.Route.bind('change', @updateActiveClass)

  getFullHashLocation: (location) ->
    if _.startsWith(location, NavigationComponent.ROUTE_PREFIX)
      return location
    else
      return NavigationComponent.ROUTE_PREFIX + location

  # TODO: page/PREFIX thing is a bit ugly
  updateActiveClass: (event) =>
    location = @getFullHashLocation _.first(event).path
    page = location.split('/')[2]
    # remove all current 'active' classes from all navs
    @primary_nav.find('.' + NavigationComponent.ACTIVE_CLASS).removeClass(NavigationComponent.ACTIVE_CLASS)
    @utility_nav.find('.' + NavigationComponent.ACTIVE_CLASS).removeClass(NavigationComponent.ACTIVE_CLASS)
    # detect the link to newly set to active
    if NavigationComponent.ROUTE_PREFIX + '/' == location
      active = @primary_nav.find('a[href="'+location+'"]')
    else
      active = @primary_nav.find('a[href^="/#/'+page+'"]')
    if active.length == 0  # not in primary_nav
      active = @utility_nav.find('a[href^="'+location+'"]')
    # activate the newly current link
    active.parents('li').not('.dropdown').addClass(NavigationComponent.ACTIVE_CLASS)
    active.addClass(NavigationComponent.ACTIVE_CLASS)

module.exports = NavigationComponent
