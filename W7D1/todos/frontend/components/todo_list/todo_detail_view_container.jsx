import { connect } from 'react-redux';
import ToDoDetailView from './todo_detail_view';
import { removeTodo } from '../../actions/todo_actions';

const mapDispatchToProps = dispatch => ({
  removeTodo: todo => dispatch(removeTodo(todo))
});

export default connect(null, mapDispatchToProps)(TodoDetailView);
