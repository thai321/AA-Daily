import React from "react";

class Weather extends React.Component {
  constructor() {
    super();

    this.latitude = 0;
    this.longitude = 0;

    this.state = {
      city: "",
      temperature: ""
    };

    this.fetchWeather = this.fetchWeather.bind(this);
  }

  componentDidMount() {
    navigator.geolocation.getCurrentPosition(position => {
      this.latitude = position.coords.latitude;
      this.longitude = position.coords.longitude;
      console.log(this.latitude, this.longitude);
      this.fetchWeather();
    });
  }

  fetchWeather() {
    const wReq = new XMLHttpRequest();

    const getResponse = () => {
      const response = JSON.parse(wReq.response);

      this.setState({
        city: response.name,
        temperature: Math.round(response.main.temp - 273.15)
      });
    };

    wReq.addEventListener("load", getResponse);
    wReq.open(
      "GET",
      `http://api.openweathermap.org/data/2.5/weather?lat=${this
        .latitude}&lon=${this.longitude}&appid=9c6b279f1c36ece02e7dcff91eb6f67c`
    );
    wReq.send();
  }

  render() {
    const { city, temperature } = this.state;

    return (
      <div>
        <hi>Hi Dillon!</hi>
        <header>
          <h2>
            City:
            <br />
            Temperature:
          </h2>
          <h2>
            {city}
            <br />
            {temperature}
          </h2>
        </header>
      </div>
    );
  }
}

export default Weather;

// a1dec23458f0a5489b722271453ea7a3
