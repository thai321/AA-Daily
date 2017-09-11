import React from 'react';
import { Route, Link, NavLink } from 'react-router-dom';
import Indigo from './indigo';

class Blue extends React.Component {
  render() {
    return (
      <div>
        <h2 className="blue" />
        {/* Links here */}
        {/*Phase I and II*/}
        {/*<Link to="/blue/indigo">Add Indigo</Link>*/}

        {/*Phase III*/}
        <NavLink to="/blue/indigo">Add Indigo</NavLink>

        {/* Routes here */}
        <Route path="/blue/indigo" component={Indigo} />
      </div>
    );
  }
}

export default Blue;
