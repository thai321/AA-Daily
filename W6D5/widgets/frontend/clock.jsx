import React from 'react';

class Clock extends React.Component {
  constructor() {
    super();
    this.tickerId = 0;

    this.state = {
      time: new Date()
    };

    this.tick = this.tick.bind(this);
  }

  tick() {
    console.log('ticktick');
    this.tickerId += 1;
    this.setState({ time: new Date() });
  }

  componentDidMount() {
    const ticker = setInterval(this.tick, 1000);
  }

  componentWillUnmount() {
    this.tickerId = 0;
  }

  render() {
    const fullDate = this.state.time.toDateString();

    const hours = this.state.time.getHours();
    const minutes = this.state.time.getMinutes();
    const seconds = this.state.time.getSeconds();
    const GMT = this.state.time.toGMTString();
    return (
      <div>
        <header>
          <h2>
            Time:
            <br />
            Date:
          </h2>
          <h2>
            {hours}:{minutes}:{seconds}
            <br />
            {fullDate}
          </h2>
        </header>
      </div>
    );
  }
}

export default Clock;
