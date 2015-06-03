Spine   = @Spine or require 'spine'
Message = require 'models/message'

class NavigationComponent extends Spine.Controller
  elements:
    '.navbar-primary': 'primary_nav'
    '.navbar-utility': 'utility_nav'

  events:
    'click .spine-clear-messages': 'destroyMessages'

  constructor: ->
    super
    Message.bind 'refresh change', @render

    # create a new router instance so we can listen to route changes
    # independent of the other app logic
    @router = Spine.Route.create()

    # utility navigation
    @router.add /^\/administration\/roles(\/.*)?$/, =>
      @activateLink(@utility_nav, '/#/administration/roles')
    @router.add /^\/administration\/users(\/.*)?$/, =>
      @activateLink(@utility_nav, '/#/administration/users')
    @router.add /^\/messages(\/.*)?$/, =>
      @activateLink(@utility_nav, '/#/messages')

    # primary navigation
    @router.add /^\/binaries(\/.*)?$/, =>
      @activateLink(@primary_nav, '/#/binaries')
    @router.add /^\/servers(\/.*)?$/,  =>
      @activateLink(@primary_nav, '/#/servers')
    @router.add /^\/$/, => @activateLink(@primary_nav, '/#/')

    @render()

  activateLink: (nav, link) ->
    # remove active class from all navs
    @primary_nav.find('.active').removeClass('active')
    @utility_nav.find('.active').removeClass('active')

    # add active again to current one
    switch nav
      when @primary_nav
        nav.find('a[href="'+link+'"]').parent('li').addClass('active')
      when @utility_nav
        nav.find('a[href="'+link+'"]').parents('li').not('.dropdown').addClass('active')

  destroyMessages: -> Message.destroyAll()

  render: => @html @template Message.all()

  template: (messages) ->
    require('views/components/navigation')
      messages: messages

module?.exports = NavigationComponent
