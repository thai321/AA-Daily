import React from "react";
import ItemDetailContainer from "./item_detail_container";

const ItemDetail = ({ item }) => (
  <ul>
    <li>
      <h4>{item.name}</h4>
    </li>
    <li>{item.happiness}</li>
    <li>{item.price}</li>
  </ul>
);

export default ItemDetail;
