import React from 'react';

class Autocomplete extends React.Component {
  constructor(props) {
    super(props);

    this.state = { inputVal: '' };

    this.handleClick = this.handleClick.bind(this);
    this.handleInput = this.handleInput.bind(this);
  }

  handleClick(event) {
    this.setState({ inputVal: event.target.innerText });
  }

  handleInput(event) {
    this.setState({ inputVal: event.target.value });
  }

  findName() {
    if (this.state.inputVal.length === 0) return this.props.names;

    const result = [];

    const subNameSearch = this.state.inputVal.toLowerCase();
    this.props.names.forEach(name => {
      const subName = name.slice(0, this.state.inputVal.length);
      if (subNameSearch === subName.toLowerCase()) result.push(name);
    });

    return result;
  }

  showResult() {
    return this.findName().map(name =>
      <li key={name} onClick={this.handleClick}>
        {name}
      </li>
    );
  }

  render() {
    return (
      <div className="autocomplete">
        <h1>Autocomplete</h1>
        <input value={this.state.inputVal} onChange={this.handleInput} />
        <ul>
          {this.showResult()}
        </ul>
      </div>
    );
  }
}

export default Autocomplete;
