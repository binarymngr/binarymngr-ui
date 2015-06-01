require 'spine'
require 'spine/lib/ajax'
require 'spine/lib/bindings'
require 'spine/lib/manager'
require 'spine/lib/relation'
require 'spine/lib/route'

# this is a good place to do settings that aren't related to spine
Request = require 'lib/http/request'
Request.bind 'ready', (rqst) ->
  window.rqst = rqst
