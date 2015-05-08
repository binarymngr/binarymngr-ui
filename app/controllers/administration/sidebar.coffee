Spine = @Spine or require('spine')
$     = Spine.$

class AdministrationSidebar extends Spine.Controller
  className: 'col-sm-3 col-md-2 col-sm-pull-9 col-md-pull-10 sidebar-pf sidebar-pf-left'
  elements:
    '.items': 'sections_nav'

  constructor: ->
    super
    @html require('views/administration/sidebar')()

    # TODO: subsections are not catched by that glob
  #   @routes
  #     '/administration/*section': (params) =>
  #       @updateActiveClass params
  #
  # updateActiveClass: (params) =>
  #   @sections_nav.find('.active').removeClass('active')
  #
  #   section = params.section
  #   @sections_nav.find('li').each (index, section_li) =>
  #     li = $(section_li)
  #     link = li.find('a')
  #     if _.endsWith(link.attr('href'), section)
  #       $(li, link).addClass('active')

module?.exports = AdministrationSidebar
