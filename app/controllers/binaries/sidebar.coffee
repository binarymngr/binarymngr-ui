Spine    = @Spine or require 'spine'
Category = require 'models/binary_category'

class BinariesSidebar extends Spine.Controller
  className: 'col-sm-3 col-md-2 col-sm-pull-9 col-md-pull-10 sidebar-pf sidebar-pf-left'
  elements:
    '.nav-category': 'category_nav'

  constructor: ->
    super

    # create a new router instance so we can listen to route changes
    # independent of the other app logic
    @router = Spine.Route.create()

    @router.add /^\/binaries\/categories(\/.*)?$/, (params) =>
      @activateLink '/#' + params?.match?[0]
    @router.add /^\/binaries(\/.*)?$/, =>
      @activateLink ''

    Category.bind 'refresh change', @render
    do @render

  activateLink: (link) =>
    # remove active class from all categories
    @category_nav.find('.active').removeClass('active')
    # add active again to current one
    @category_nav.find('a[href="'+link+'"]').parent('li').addClass('active')

  render: => @html @template Category.all()

  template: (categories) ->
    require('views/binaries/sidebar')
      categories: categories

module?.exports = BinariesSidebar
