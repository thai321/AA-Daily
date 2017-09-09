import React from "react";

class Autocomplete extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      inputVal: ""
    };
  }

  render() {
    return (
      <div>
        <input />
        <ul>{this.props.names.map(name => <li>{name}</li>)}</ul>
      </div>
    );
  }
}

export default Autocomplete;
