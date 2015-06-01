require 'spine'
require 'spine/lib/ajax'
require 'spine/lib/bindings'
require 'spine/lib/manager'
require 'spine/lib/relation'
require 'spine/lib/route'

# this is a good place to do settings that aren't related to spine

Request = require 'lib/http/request'

window.rqst = Request.get()  # set the initial dummy request
Request.bind 'ready', (rqst) ->
  window.rqst = rqst
  $(window).trigger 'resize'  # PF sidebar heigth hack
