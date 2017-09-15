import React from "react";
import { Link } from "react-router-dom";

const Item = ({ item }) => (
  <li>
    <Link to={`/pokemon/${item.pokemon_id}/item/${item.id}`}>
      <img src={item.image_url} />
    </Link>
  </li>
);

export default Item;
