Spine      = @Spine or require('spine')
Controller = require('framework/core').Controller
Message    = require('models/message')
RecordForm = require('framework/controllers').RecordForm

class MessageFormPage extends Controller
  className: 'col-xs-12'

  constructor: ->
    super
    @form = new MessageForm
    @active @form.render
    @render()

  render: => @html @form.render()

class MessageForm extends RecordForm
  model: Message
  url  : '/messages'
  view : 'views/messages/form'

module?.exports      = MessageFormPage
module?.exports.Form = MessageForm
