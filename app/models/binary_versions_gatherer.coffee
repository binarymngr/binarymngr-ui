Spine        = @Spine or require('spine')
Notification = require('services/notification_service')

class BinaryVersionsGatherer extends Spine.Model
  @configure 'BinaryVersionsGatherer', 'name', 'description'

  @extend  Spine.Model.Ajax
  @url: '/binaries/versions/gatherers'

  binaries: =>
    Binary = require('models/binary')
    (binary.select (b) => b.versions_gatherer is @name)

  hasBinaries: => @binaries().length isnt 0

  validate: -> 'BinaryVersionsGatherer are read-only and cannot be created'

module?.exports = BinaryVersionsGatherer
