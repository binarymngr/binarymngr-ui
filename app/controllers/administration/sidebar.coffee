Spine = @Spine or require('spine')

# TODO: mark current section as active

class AdministrationSidebar extends Spine.Controller
  className: 'col-sm-3 col-md-2 col-sm-pull-9 col-md-pull-10 sidebar-pf sidebar-pf-left'

  constructor: ->
    super
    @html require('views/administration/sidebar')()

module.exports = AdministrationSidebar
