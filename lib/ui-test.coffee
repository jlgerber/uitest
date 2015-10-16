UiTestView = require './ui-test-view'
{CompositeDisposable} = require 'atom'
DOMListener = require 'dom-listener'
TestUiView = require './testui-view'

module.exports = UiTest =
  uiTestView: null
  modalPanel: null
  subscriptions: null
  listener: null
  classDotCpp:null
  classDotH:null
  bracket:null
  # parameters
  virtualDestructor: 'yes'
  copyConstructor: 'yes'
  assignmentOperator: 'yes' # lame that it doesnt take a bool

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
      @createClass(@uiTestView.getText())

    @listener.add '.ui-test-input', 'keypress', (event) => @validateInput event, true

  createClass: (cls) =>

    unless @classDotCpp?
      path = require('path')
      @bracket = require('bracket-templates')
      cdcpp = path.join(__dirname, "../etc/classDotCPP.txt")
      cdh = path.join(__dirname,"../etc/classDotH.txt")

      @classDotCpp = fs.readFileSync(cdcpp)
      @classDotH = fs.readFileSync(cdh)

    data =
      name: cls
      virtualDestructor: @virtualDestructor
      copyConstructor: @copyConstructor
      assignmentOperator: @assignmentOperator

    console.log data
    alert( @bracket.render(String(@classDotH), data ) )
    alert( @bracket.render(String(@classDotCpp), data ) )

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
