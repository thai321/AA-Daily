import { RECEIVE_ALL_POSTS,
         RECEIVE_POST,
         REMOVE_POST } from '../actions/post_actions';
import merge from 'lodash/merge';

const PostsReducer = (oldState = {}, action) => {
  Object.freeze(oldState);
  switch (action.type) {
    case RECEIVE_ALL_POSTS:
      return merge({}, action.posts);
    case RECEIVE_POST:
      return merge({}, oldState, {[action.post.id]: action.post});
    case REMOVE_POST:
      let newState = merge({}, oldState);
      delete newState[action.post.id];
      return newState;
    default:
      return oldState;
  }
};

export default PostsReducer;
