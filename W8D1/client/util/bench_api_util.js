export const fetchBenches = filters => {
  return $.ajax({
    method: 'GET',
    url: 'api/benches',
    data: filters,
    error: err => console.log(err)
  });
};

/*

 google map bounds will be in the following format:
 {
   "northEast"=> {"lat"=>"37.80971", "lng"=>"-122.39208"},
   "southWest"=> {"lat"=>"37.74187", "lng"=>"-122.47791"}
 }
... query logic goes here

const filters = {
  bounds: {
    northEast: {
      lat: 37.80971, lng: -122.39208
    },
    southWest: {
      lat: 37.74187, lng: -122.47791
    }
  }
}

BenchUtil.fetchBenches(filters)

*/
