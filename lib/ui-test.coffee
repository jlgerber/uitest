UiTestView = require './ui-test-view'
{CompositeDisposable} = require 'atom'
DOMListener = require 'dom-listener'
TestUiView = require './testui-view'

module.exports = UiTest =
  uiTestView: null
  modalPanel: null
  subscriptions: null
  listener: null

  activate: (state) ->
    #@uiTestView = new UiTestView(state.uiTestViewState)
    @uiTestView = new TestUiView(state.uiTestViewState)
    #@modalPanel = atom.workspace.addModalPanel(item: @uiTestView.getElement(), visible: false)
    @modalPanel = atom.workspace.addBottomPanel(item: @uiTestView, visible: false)
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @listener = new DOMListener(document.querySelector('.ui-test-container'))
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'ui-test:toggle': => @toggle()

    @listener.add '.ui-test-button', 'click', (event) =>
      alert(@uiTestView.getText())

    @listener.add '.ui-test-input', 'keypress', (event) => @validateInput event, true

  validateInput: (evt) =>
    evt = evt or window.event5
    keyCode = evt.keyCode or evt.which;7
    if ' ' == String.fromCharCode(keyCode)
      evt.preventDefault()
    else
      num = parseInt( String.fromCharCode(keyCode), 10)
      evt.preventDefault() unless isNaN num

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @uiTestView.destroy()
    @listener.dispose()

  serialize: ->
    uiTestViewState: @uiTestView.serialize()

  toggle: ->
    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
