Spine   = @Spine or require 'spine'
Service = require 'services/service'
$       = Spine.$

#
# The NotificationService class allows showing notifications
# to the user. It uses the noty jQuery library for that purpose.
#
class NotificationService extends Service
  #
  # Noty notification types constants.
  #
  @ALERT      : 'alert'
  @CONFIRM    : 'confirm'
  @ERROR      : 'error'
  @INFORMATION: 'information'
  @SUCCESS    : 'success'
  @WARNING    : 'warning'

  #
  # Constructor to initialize a new instance.
  #
  # defaults: A 'settings' object that gets passed to noty
  #
  constructor: (defaults) ->
    super

    _.extend $.noty.defaults,
      layout: 'topRight'
      theme: 'relax'
      type: 'information'
      animation:
        open: 'animated fadeInDown'
        close: 'animated fadeOutDown'
      timeout: 2250
      force: true
      maxVisible: 5
      closeWith: ['button', 'click']
    _.extend $.noty.defaults, defaults

  #
  # Shows a new notification with level 'ALERT'.
  #
  # alert:   The content to display.
  # options: Optional options to pass to noty.
  #
  # return: void
  #
  alert: (alert, options = {}) ->
    @notify NotificationService.ALERT, alert, options
    return

  #
  # Shows a new notification with level 'CONFIRM'.
  #
  # alert:   The content to display.
  # options: Optional options to pass to noty.
  #
  # return: void
  #
  confirm: (question, options = {}) ->
    @notify NotificationService.CONFIRM, question, options
    return

  #
  # Shows a new notification with level 'ERROR'.
  #
  # alert:   The content to display.
  # options: Optional options to pass to noty.
  #
  # return: void
  #
  error: (error, options = {}) ->
    @notify NotificationService.ERROR, error, options
    return

  #
  # Shows a new notification with level 'INFO'.
  #
  # alert:   The content to display.
  # options: Optional options to pass to noty.
  #
  # return: void
  #
  info: (info, options = {}) ->
    @notify NotificationService.INFORMATION, info, options
    return

  #
  # Creates and shows a new notification.
  #
  # type:    The notification type.
  # text:    The content to show.
  # options: Optional options to pass to noty.
  #
  # return: void
  #
  notify: (type, text, options = {}) ->
    options = _.extend {
      text: text
      type: type
    }, options

    noty options
    return

  #
  # Shows a new notification with level 'SUCCESS'.
  #
  # alert:   The content to display.
  # options: Optional options to pass to noty.
  #
  # return: void
  #
  success: (sucess, options = {}) ->
    @notify NotificationService.SUCCESS, sucess, options
    return

  #
  # Shows a new notification with level 'WARNING'.
  #
  # alert:   The content to display.
  # options: Optional options to pass to noty.
  #
  # return: void
  #
  warning: (warning, options = {}) ->
    @notify NotificationService.WARNING, warning, options
    return

module?.exports = new NotificationService
