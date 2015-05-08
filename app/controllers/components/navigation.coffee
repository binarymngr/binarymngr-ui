Spine = @Spine or require('spine')

class NavigationComponent extends Spine.Controller
  elements:
    '.navbar-primary': 'primary_nav'
    '.navbar-utility': 'utility_nav'

  constructor: ->
    super

    @html require('views/components/navigation')()

    # TODO: subsections are not catched by that glob
  #   @routes
  #     '/administration/*section': (params) =>
  #       @updateUtilityNavActiveClass params
  #     '/*section': (params) =>
  #       @updatePrimaryNavActiveClass params
  #
  # updatePrimaryNavActiveClass: (params) =>
  #   @primary_nav.find('.active').removeClass('active')
  #   @utility_nav.find('.active').removeClass('active')
  #
  #   section = params.section
  #   @primary_nav.find('li').each (index, section_li) =>
  #     li = $(section_li)
  #     link = li.find('a')
  #     if _.endsWith(link.attr('href'), section)
  #       $(li, link).addClass('active')
  #
  # updateUtilityNavActiveClass: (params) =>
  #   @primary_nav.find('.active').removeClass('active')
  #   @utility_nav.find('.active').removeClass('active')
  #
  #   section = params.section
  #   @utility_nav.find('li').each (index, section_li) =>
  #     li = $(section_li)
  #     link = li.find('a')
  #     if _.endsWith(link.attr('href'), section)
  #       $(li, link).addClass('active')

module?.exports = NavigationComponent
