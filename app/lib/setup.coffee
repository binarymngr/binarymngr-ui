require('spine')
require('spine/lib/ajax')
require('spine/lib/manager')
require('spine/lib/relation')
require('spine/lib/route')

# HTTP request simulation
Request = require('lib/http/request')
Request.var = window.server
window.rqst = Request.hydrate()
Request.bind 'ready', (rqst) ->
  window.rqst = rqst
  $(window).trigger 'resize'  # PF sidebar
