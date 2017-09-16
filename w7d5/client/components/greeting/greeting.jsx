import React from 'react';
import { Link } from 'react-router-dom';

const Greeting = ({ currentUser, logout }) =>
  currentUser ? (
    <div>
      <h1>Welcome {currentUser.username}</h1>
      <button onClick={logout}>Log Out</button>
    </div>
  ) : (
    <div>
      <h1>Login</h1>
      <Link to="/signup">Signup</Link>
      <Link to="/login">Login</Link>
    </div>
  );

export default Greeting;
