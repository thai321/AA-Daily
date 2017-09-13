import { connect } from 'react-redux';
import ToDoDetailView from './todo_detail_view';
import { deleteTodo } from '../../actions/todo_actions';

const mapDispatchToProps = dispatch => ({
  deleteTodo: todo => dispatch(deleteTodo(todo))
});

export default connect(null, mapDispatchToProps)(TodoDetailView);
