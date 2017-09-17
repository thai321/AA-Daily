import React from 'react';
import { withRouter } from 'react-router-dom';

class SessionForm extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      username: '',
      password: ''
    };

    this.handleSumbit = this.handleSumbit.bind(this);
  }

  handleSumbit(e) {
    e.preventDefault();
    const user = Object.assign({}, this.state);
    console.log(user);
    this.props.processForm(user);
  }

  update(type) {
    return e =>
      this.setState({
        [type]: e.currentTarget.value
      });
  }

  render() {
    return (
      <div>
        <form onSubmit={this.handleSumbit}>
          Welcome to BenchBnB!
          <br />
          {this.props.formType} Page
          <br />
          <label>
            Username:
            <input
              type="text"
              value={this.state.username}
              onChange={this.update('username')}
            />
          </label>
          <br />
          <label>
            Password
            <input
              type="password"
              value={this.state.password}
              onChange={this.update('password')}
            />
            <label />
            <br />
            <input type="submit" value="Submit" />
          </label>
        </form>
      </div>
    );
  }
}

export default SessionForm;
