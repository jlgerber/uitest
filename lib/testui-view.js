/** @babel */
/** @jsx etch.dom */

import etch from 'etch';

function getMethods(obj) {
  var result = [];
  for (var id in obj) {
    try {
      if (typeof(obj[id]) == "function") {
        result.push(id );//+ ": " + obj[id].toString());
      }
    } catch (err) {
      result.push(id + ": inaccessible");
    }
  }
  return result;
}
export default class TestUiView {
  // The constructor assigns initial state, then associates the component with
  // an element via `etch.createElement`
  constructor (serializedState) {
    etch.createElement(this);
    this.refs.uiTestInput.setAttribute('mini','');
  }

  serialize () {

  }
  destroy () {
    this.remove();
  }

  getElement () {
    return this.render();
  }
  // When your component's element is created or updated, its content will be
  // based on the result of the `render` method.
  render () {
    return (
      <div className='ui-test-container'>
        <atom-text-editor className="ui-test-input" ref="uiTestInput"></atom-text-editor>
        <atom-text-editor className="ui-test-input" ref="uiTestInput2" attributes={{mini: true}}></atom-text-editor>
        <button className="ui-test-button" ref='pressButton'>Press Me</button>
      </div>
    )
  }

  getText () {
    return this.refs.uiTestInput2.getModel().getText();
  }

}
