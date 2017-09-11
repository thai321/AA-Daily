import React from 'react';

const GiphysIndexItem = ({ giphy }) => {
  return (
    <li className="giphy-li">
      <img src={giphy.images.preview_gif.url} />
    </li>
  );
};

export default GiphysIndexItem;
