export const fetchBenches = () => {
  return $.ajax({
    method: 'GET',
    url: 'api/benches',
    error: err => console.log(err)
  });
};
