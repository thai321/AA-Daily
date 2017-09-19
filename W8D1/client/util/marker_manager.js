class MarkerManager {
  constructor(map) {
    this.map = map;
    this.markers = {};
  }

  updateMarkers(benches) {
    const benchesObject = {};
    benches.forEach(bench => (benchesObject[bench.id] = bench));

    benches.forEach(bench => {
      if (!this.markers[bench.id]) this.createMarkerFromBench(bench);
    });

    Object.keys(this.markers).forEach(benchId => {
      if (benchesObject[benchId]) this.removeMarker(this.markers[benchId]);
    });
  }

  createMarkerFromBench(bench) {
    const myLatlng = new google.maps.LatLng(bench.lat, bench.lng);

    const marker = new google.maps.Marker({
      benchId: bench.id,
      position: myLatlng,
      map: this.map
    });

    // this.map[bench.id] = marker;
    marker.setMap(this.map);
    this.markers[bench.id] = marker;
  }

  removeMarker(marker) {
    delete this.markers[marker.benchId];
  }
}

export default MarkerManager;
