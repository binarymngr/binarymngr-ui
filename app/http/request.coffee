Spine = @Spine or require('spine')

class Request extends Spine.Module
  @extend Spine.Events

  @current = null

  constructor: ->
    super

    @date = new Date
    @location = _.trimLeft(window.location.hash, '#')
    @referrer = Request.current?.location

  @get: ->
    return _.clone(Request.current, true)

  @setCurrent: (rqst) =>
    unless rqst.location is ''  # i.e. dropdown triggers
      @current = _.clone(rqst, true)
      Request.trigger 'change', Request.get()

module?.exports = Request
