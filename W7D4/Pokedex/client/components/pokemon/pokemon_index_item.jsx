import React from "react";
import { Link } from "react-router-dom";

class PokemonIndexItem extends React.Component {
  render() {
    const { id, name, image_url } = this.props.pokemon;
    return (
      <section className="pokedex">
        <ul>
          <li>
            <Link to={`/pokemon/${id}`}>{name}</Link>
            <img src={image_url} />
          </li>
        </ul>
      </section>
    );
  }
}
export default PokemonIndexItem;
