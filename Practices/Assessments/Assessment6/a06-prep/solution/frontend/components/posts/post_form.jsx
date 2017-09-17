import React from 'react';

class PostForm extends React.Component {
  constructor(props) {
    super(props);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.state = this.props.post;
  }

  componentDidMount() {
    if (this.props.match.params.postId) {
      this.props.fetchPost(this.props.match.params.postId);
    }
  }

  componentWillReceiveProps(newProps) {
    this.setState(newProps.post);
  }

  update(field) {
    return (e) => {
      this.setState({[field]: e.target.value});
    };
  }

  handleSubmit(e) {
    e.preventDefault();
    this.props.action(this.state).then(() => this.props.history.push('/'));
  }

  render () {
    const text = this.props.formType === 'new' ? "Create Post" : "Update Post";
    return (
      <div>
        <h3>{text}</h3>
        <form onSubmit={this.handleSubmit}>
          <label>Title
            <input
              type="text"
              value={this.state.title}
              onChange={this.update('title')} />
          </label>

          <label>
            <textarea
              value={this.state.body}
              onChange={this.update('body')} />
          </label>

          <input type="submit" value={text} />
        </form>
      </div>
    );
  }
}

export default PostForm;
