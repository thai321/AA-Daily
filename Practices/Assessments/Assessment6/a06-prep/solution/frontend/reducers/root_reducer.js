import { combineReducers } from 'redux';
import PostsReducer from './posts_reducer';

export default combineReducers({
  posts: PostsReducer
});
