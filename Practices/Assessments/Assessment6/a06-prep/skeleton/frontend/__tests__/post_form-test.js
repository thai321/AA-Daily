/* globals jest */

import React from 'react';
import { Route } from 'react-router-dom';
import PropTypes from 'prop-types';
import configureMockStore from 'redux-mock-store';
import thunk from 'redux-thunk';
import { mount } from 'enzyme';
import MockRouter from 'react-mock-router';
import * as PostActions from '../actions/post_actions';
import PostFormContainer from '../components/posts/post_form_container';

const testPost = {
  id: 1,
  title: "Title",
  body: "Body"
};
const middlewares = [ thunk ];
const mockStore = configureMockStore(middlewares);
const testStore = mockStore({ posts: { 1: testPost } });

describe('post form container', () => {
  let postFormWrapper,
      titleInput,
      bodyInput;

  beforeEach(() => {
    PostActions.updatePost = jest.fn(post => dispatch => {
      return Promise.resolve(post);
    });
    PostActions.createPost = jest.fn(post => dispatch => {
      return Promise.resolve(post);
    });
    PostActions.fetchPost = jest.fn(id => dispatch => {
    });
  });

  describe('creating a new post', () => {
    beforeEach(() => {
      postFormWrapper = mount(
        <MockRouter path={"/"}>
            <PostFormContainer store={testStore} />
        </MockRouter>
      ).find('PostForm');
   
      titleInput = postFormWrapper.find('input').filterWhere(input => (
        input.props().type === 'text'
      ));
      bodyInput = postFormWrapper.find('textarea');
    });

    it('correctly maps state to props', () => {
      expect(postFormWrapper.props().post).toEqual({
        title: "", body: ""
      });
    });

    it('correctly maps dispatch to props', () => {
      expect(postFormWrapper.props().action).toBeDefined();
    });

    it('pre-fills title and body input fields with empty string', () => {
      expect(titleInput.props().value).toEqual('');
      expect(bodyInput.props().value).toEqual('');
    });

    it('updates the title and body fields when they change', () => {
      titleInput.simulate('change', { target: { value: 'telephone' }});
      expect(titleInput.props().value).toEqual('telephone');
    });

    it('triggers the correct action when submitted', () => {
      const newPost = { title: 'testTitle', body: 'testBody' };
      titleInput.simulate('change', { target: { value: newPost.title }});
      bodyInput.simulate('change', { target: { value: newPost.body }});
      postFormWrapper.find('form').simulate('submit');

      expect(PostActions.createPost).toBeCalledWith(newPost);
    });
  });

  describe('updating an existing post', () => {
    beforeEach(() => {
      postFormWrapper = mount(
        <MockRouter path={"/posts/:postId/edit"} params={{postId: testPost.id}}>
            <PostFormContainer store={testStore} />
        </MockRouter>
      ).find('PostForm');

      titleInput = postFormWrapper.find('input').filterWhere(input => (
        input.props().type === 'text'
      ));
      bodyInput = postFormWrapper.find('textarea');
    });

    it('correctly maps state to props', () => {
      expect(postFormWrapper.props().post).toEqual(testPost);
    });

    it('correctly maps dispatch to props', () => {
      const props = postFormWrapper.props();

      expect(props.fetchPost).toBeDefined();
      expect(props.action).toBeDefined();
    });

    it('pre-fills title and body input fields with post data from the store', () => {
      expect(PostActions.fetchPost).toBeCalledWith(testPost.id);
      expect(titleInput.props().value).toEqual(testPost.title);
      expect(bodyInput.props().value).toEqual(testPost.body);
    });

    it('triggers the correct action when submitted', () => {
      postFormWrapper.find('form').simulate('submit');
      expect(PostActions.updatePost).toBeCalledWith(testPost);
    });
  });
});
