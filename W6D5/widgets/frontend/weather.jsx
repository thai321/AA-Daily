import React from 'react';
import { API_WEATHER } from './key';

class Weather extends React.Component {
  constructor() {
    super();

    this.latitude = 0;
    this.longitude = 0;

    this.state = {
      city: '',
      temperature: ''
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
      console.log(response);

      this.setState({
        city: response.name,
        temperature: Math.round(response.main.temp - 273.15)
      });
    };

    wReq.addEventListener('load', getResponse);
    wReq.open(
      'GET',
      `http://api.openweathermap.org/data/2.5/weather?lat=${this
        .latitude}&lon=${this.longitude}&appid=${API_WEATHER}`
    );
    wReq.send();
  }

  render() {
    const { city, temperature } = this.state;

    return (
      <div>
        <header className="header-auto">
          <h2>
            City:
            <br />
            Temperature:
          </h2>
          <h2>
            {city}
            <br />
            {temperature} &#176; C
          </h2>
        </header>
      </div>
    );
  }
}

export default Weather;
