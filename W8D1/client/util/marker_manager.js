export default class MarkerManager {
  constructor(map) {
    this.map = map;
    this.markers = {};
  }

  updateMarkers(benches) {
    benches.forEach(bench => {
      if (!this.markers[bench.id]) this.createMarkerFromBench(bench);
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
}
