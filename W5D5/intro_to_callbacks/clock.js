class Clock {
  constructor() {
    this.date = new Date();
    this.hours = this.date.getHours();
    this.minutes = this.date.getMinutes();
    this.seconds = this.date.getSeconds();

    this.printTime(); // Display time
    this._tick(); // start to tick
    setInterval(this._tick.bind(this), 1000);
  }

  printTime() {
    const timeDisplay = `${this.hours}:${this.minutes}:${this.seconds}`;
    console.log(timeDisplay);
  }

  _tick() {
    this.seconds++;
    if (this.seconds === 60) {
      this.seconds = 0;
      this.incrementMinutes();
    }

    this.printTime();
  }

  incrementMinutes() {
    this.minutes++;
    if (this.minutes === 60) {
      this.minutes = 0;
      this.incrementHours();
    }
  }

  incrementHours() {
    this.hours = (this.hours + 1) % 24;
  }
}

// const clock = new Clock();
