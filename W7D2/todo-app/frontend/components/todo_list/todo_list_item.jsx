import React from 'react';

import ToDoDetailView from './todo_detail_view';

class TodoListItem extends React.Component {
  constructor() {
    super();

    this.state = { hide: true };

    this.handleRemove = this.handleRemove.bind(this);
    this.handleDone = this.handleDone.bind(this);
    this.displayDetail = this.displayDetail.bind(this);
  }

  handleRemove() {
    this.props.removeTodo(this.props.todo);
  }

  handleDone() {
    const { todo, todo: { done } } = this.props;

    const state = done ? false : true;
    const newTodo = Object.assign({}, todo, { done: state });
    this.props.updateTodo(newTodo);
  }

  displayDone() {
    return this.props.todo.done ? 'Undo' : 'Done';
  }

  displayDetail() {
    const { hide } = this.state;
    const { todo } = this.props;

    if (hide) return <ToDoDetailView todo={todo} />;
  }

  render() {
    const { title } = this.props.todo;
    const { todo } = this.props;

    return (
      <div>
        <li>
          {title}
          <button onClick={this.handleRemove}>remove</button>
          <button onClick={this.handleDone}>
            {this.displayDone()}
          </button>
          {this.displayDetail()}
        </li>
      </div>
    );
  }
}

export default TodoListItem;
