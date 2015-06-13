Spine = @Spine or require('spine')

# Constants
DUMMY_VIEW = 'framework/views/dummy'

# Controllers
class Controller extends Spine.Controller
  render:   => @el
  template: -> # NOP

class ViewController extends Controller
  view: DUMMY_VIEW

  constructor: ->
    super
    throw new Error('@view is required') unless @view

  render:   => @html @template()
  template: => require(@view)()

module?.exports                = {}
# Constants
module?.exports.DUMMY_VIEW     = DUMMY_VIEW
# Controllers
module?.exports.Controller     = Controller
module?.exports.ViewController = ViewController
