import { connect } from 'react-redux';
import TodoList from './todo_list';
import {
  createTodo,
  removeTodo,
  updateTodo,
  fetchTodos
} from '../../actions/todo_actions';

// state avaliable for TodoList
const mapStateToProps = state => ({
  todos: allTodos(state)
});

// action function avaliable for TodoList
const mapDispatchToProps = dispatch => ({
  createTodo: todo => dispatch(createTodo(todo)),
  removeTodo: todo => dispatch(removeTodo(todo)),
  updateTodo: todo => dispatch(updateTodo(todo)),
  fetchTodos: () => dispatch(fetchTodos())
});

export default connect(mapStateToProps, mapDispatchToProps)(TodoList);
