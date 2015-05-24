Spine = @Spine or require('spine')

class Request extends Spine.Module
  @extend Spine.Events

  @current = new Request  # fixes cannot read 'is_admin' of null on 1st load

  constructor: ->
    super

    @csrf_token = laravel.csrf_token
    @date = new Date
    @location = _.trimLeft window.location.hash, '#'
    @referrer = Request.current.location
    @user = laravel.user
    # immutability
    Object.freeze @date
    Object.freeze this

  @get: =>
    return @current

  @hydrate: =>
    rqst = new Request
    unless rqst.location is ''  # i.e. dropdown triggers
      @current = rqst
      Request.trigger 'ready', @get()

module?.exports = Request
