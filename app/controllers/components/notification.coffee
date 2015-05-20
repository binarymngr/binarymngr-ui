Spine = @Spine or require('spine')
$     = Spine.$

class NotificationService extends Spine.Module
  constructor: ->
    console.log("NotificationService")

module?.exports = NotificationService
