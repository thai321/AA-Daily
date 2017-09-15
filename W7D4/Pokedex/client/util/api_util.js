export const fetchAllPokemon = () => {
  return $.ajax({
    method: "GET",
    url: "/api/pokemon"
  });
};

export const fetchAPokemon = id => {
  return $.ajax({
    method: "GET",
    url: `/api/pokemon/${id}`
  });
};
