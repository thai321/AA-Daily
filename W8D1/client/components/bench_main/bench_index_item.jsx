import React from 'react';

const BenchIndexItem = ({ bench }) => {
  return (
    <div>
      <h2>{bench.description}</h2>
      <h3>{bench.lat}</h3>
      <h3>{bench.lng}</h3>
    </div>
  );
};

export default BenchIndexItem;
