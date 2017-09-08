import React from 'react';

class Calculator extends React.Component {
  constructor(props) {
    super(props);

    this.state = { num1: '', num2: '', result: 0 };
    this.setNum1 = this.setNum1.bind(this);
    this.setNum2 = this.setNum2.bind(this);

    this.add = this.add.bind(this);
    this.substract = this.substract.bind(this);
    this.multiply = this.multiply.bind(this);
    this.divide = this.divide.bind(this);
    this.clear = this.clear.bind(this);
  }

  setNum1(e) {
    const num1 = e.target.value ? parseInt(e.target.value) : '';
    this.setState({ num1 });
  }

  setNum2(e) {
    const num2 = e.target.value ? parseInt(e.target.value) : '';
    this.setState({ num2 });
  }

  add(e) {
    e.preventDefault();
    this.setState({ result: this.state.num1 + this.state.num2 });
  }

  substract(e) {
    e.preventDefault();
    this.setState({ result: this.state.num1 - this.state.num2 });
  }

  multiply(e) {
    e.preventDefault();
    this.setState({ result: this.state.num1 * this.state.num2 });
  }

  divide(e) {
    e.preventDefault();
    this.setState({ result: this.state.num1 / this.state.num2 });
  }

  clear(e) {
    e.preventDefault();
    this.setState({ num1: '', num2: '', result: 0 });
  }

  render() {
    const { num1, num2 } = this.state;

    return (
      <div>
        <h1>Calculator</h1>
        <h1>
          {this.state.result}
        </h1>

        <label>
          Num1:
          <input onChange={this.setNum1} value={num1} />
        </label>

        <label>
          Num2:
          <input onChange={this.setNum2} value={num2} />
        </label>

        <button onClick={this.clear}>Clear</button>
        <br />
        <br />
        <button onClick={this.add}>Add</button>
        <button onClick={this.substract}>Substract</button>
        <button onClick={this.multiply}>Multiply</button>
        <button onClick={this.divide}>Divide</button>
      </div>
    );
  }
}

export default Calculator;
