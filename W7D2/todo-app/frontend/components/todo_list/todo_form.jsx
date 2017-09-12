import React from 'react';
import { uniqueId } from '../../util/util';

class TodoForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      id: '',
      title: '',
      body: '',
      done: false
    };

    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleInput = this.handleInput.bind(this);
  }

  handleInput(type) {
    return e => this.setState({ [type]: e.target.value });
  }

  handleSubmit(e) {
    e.preventDefault();
    const newTodo = Object.assign({}, this.state, { id: uniqueId() });
    // debugger;
    this.props
      .createTodo(newTodo)
      .then(() => this.setState({ title: '', body: ' ' }));
  }

  render() {
    const { id, title, body, done } = this.state;

    return (
      <div>
        <h1>Todo Form</h1>

        <form onSubmit={this.handleSubmit}>
          <label>
            Title
            <input
              type="text"
              onChange={this.handleInput('title')}
              value={title}
            />
          </label>
          <label>
            Body
            <textarea onChange={this.handleInput('body')} value={body}>
              body todo
            </textarea>
          </label>

          <button>Submit</button>
        </form>
      </div>
    );
  }
}

export default TodoForm;
