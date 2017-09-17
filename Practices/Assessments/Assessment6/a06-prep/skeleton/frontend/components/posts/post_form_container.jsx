import { connect } from 'react-redux';
import { withRouter } from 'react-router-dom';
import PostForm from './post_form';
import { fetchPost, createPost, updatePost } from '../../actions/post_actions';
