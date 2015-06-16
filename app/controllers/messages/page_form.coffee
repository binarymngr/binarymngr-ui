Spine      = @Spine or require('spine')
Controller = require('framework/core').Controller
Form       = require('framework/controllers').RecordForm
Message    = require('models/message')

class MessageFormPage extends Controller
  className: 'col-xs-12'

  constructor: ->
    super
    @form = new MessageForm
    @active @form.render
    @render()

  render: => @html @form.render()

class MessageForm extends Form
  model: Message
  url  : '/messages'
  view : 'views/messages/form'

module?.exports      = MessageFormPage
module?.exports.Form = MessageForm
