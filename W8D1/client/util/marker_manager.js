export default class MarkerManager {
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

    this.markers.forEach(marker => {
      if (!benchesObject[marker.benchId]) this.removemarker(marker);
    });
  }

  createMarkerFromBench(bench) {
    const myLatlng = new google.maps.LatLng(bench.lat, bench.lng);

    const marker = new google.maps.Marker({
      benchId: bench.id,
      myLatlng,
      map: this.map
    });
  }

  removemarker(marker) {
    delete this.markers[marker.benchId];
  }
}
