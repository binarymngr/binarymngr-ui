Spine   = @Spine or require('spine')
Service = require('services/service')
$       = Spine.$

class NotificationService extends Service
  @ALERT      : 'alert'
  @CONFIRM    : 'confirm'
  @ERROR      : 'error'
  @INFORMATION: 'information'
  @SUCCESS    : 'success'
  @WARNING    : 'warning'

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

  alert: (alert, options = {}) ->
    @notify NotificationService.ALERT, alert, options
    return

  confirm: (question, options = {}) ->
    @notify NotificationService.CONFIRM, question, options
    return

  error: (error, options = {}) ->
    @notify NotificationService.ERROR, error, options
    return

  info: (info, options = {}) ->
    @notify NotificationService.INFORMATION, info, options
    return

  notify: (type, text, options = {}) ->
    options = _.extend {
      text: text
      type: type
    }, options

    noty options
    return

  success: (sucess, options = {}) ->
    @notify NotificationService.SUCCESS, sucess, options
    return

  warning: (warning, options = {}) ->
    @notify NotificationService.WARNING, warning, options
    return

module?.exports = new NotificationService
