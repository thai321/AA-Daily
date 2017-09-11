import { APIKEY } from './key';

export const fetchSearchGiphys = searchTerm => {
  return $.ajax(
    `http://api.giphy.com/v1/gifs/search?q=${searchTerm}&api_key=${APIKEY}&limit=2`
  );
};
