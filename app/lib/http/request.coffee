Spine = @Spine or require 'spine'

#
# The request class can be used to have an object that
# reflects user requests (e.g. clicks).
#
# Its best placed as a global variable attached to window.
#
# Attn: The request gets its input from the global 'server' variable,
#       so make sure to provide that one.
#       At least 'csrf_token' and 'user' properties should exist.
#
class Request extends Spine.Class
  @extend Spine.Events

  #
  # Stores the current request object.
  #
  # var: lib/http/Request
  #
  @current = new Request

  #
  # Constructor to initialize a new Request instance.
  #
  # Attn: Should not be called directly.
  #
  constructor: ->
    super

    @csrf_token = server?.csrf_token
    @date = new Date
    @location = _.trimLeft window.location.hash, '#'
    @referrer = Request.current?.location
    @user = server?.user
    # immutability
    Object.freeze @date
    Object.freeze this

  #
  # Returns the current request object.
  #
  # return: lib/http/Request
  #
  @get: -> @current

  #
  # Hydrates/populates the current request with new values.
  #
  # This method is best used as a callback to e.g. window.location.hash.change
  #
  # return: lib/http/Request
  #
  @hydrate: ->
    rqst = new Request
    @current = rqst
    Request.trigger 'ready', @get()
    @get()

module?.exports = Request
