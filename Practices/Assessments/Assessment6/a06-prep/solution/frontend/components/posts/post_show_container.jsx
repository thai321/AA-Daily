import { connect } from 'react-redux';
import PostShow from './post_show';
import { fetchPost } from '../../actions/post_actions';

const mapStateToProps = (state, ownProps) => ({
  post: state.posts[ownProps.match.params.postId]
});

const mapDispatchToProps = dispatch => ({
  fetchPost: id => dispatch(fetchPost(id))
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(PostShow);
