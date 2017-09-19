import React from 'react';

import MarkerManager from '../../util/marker_manager';

class BenchMap extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    const mapOptions = {
      center: { lat: 37.7758, lng: -122.435 },
      zoom: 13
    };

    this.map = new google.maps.Map(this.mapNode, mapOptions);

    this.MarkerManager = new MarkerManager(this.map);
    console.log(this.MarkerManager);
    if (Object.keys(this.props.benches).length > 0) {
      this.MarkerManager.updateMarkers(this.props.benches);
    }
    this.mapListener();
  }

  componentDidUpdate() {
    // console.log(this.props.benches);
    this.MarkerManager.updateMarkers(this.props.benches);
    console.log(this.MarkerManager);
    this.mapListener();
  }

  mapListener() {
    google.maps.event.addListener(this.map, 'idle', () => {
      const { north, south, east, west } = this.map.getBounds().toJSON();
      const value = {
        northEast: { lat: north, lng: east },
        southWest: { lat: south, lng: west }
      };

      this.props.updateFilter('bounds', value);
    });
  }

  render() {
    return (
      <div id="map-container" ref={map => (this.mapNode = map)}>
        <h1> Map</h1>
      </div>
    );
  }
}

export default BenchMap;
