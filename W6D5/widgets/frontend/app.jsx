import React from "react";

import Clock from "./clock";
import Weather from "./weather";
import Autocomplete from "./autocomplete";

const Names = [
  "Abba",
  "Barney",
  "Barbara",
  "Jeff",
  "Jenny",
  "Sarah",
  "Sally",
  "Xander"
];

class App extends React.Component {
  render() {
    return (
      <div>
        <Clock />
        <Weather />
        <Autocomplete names={Names} />
      </div>
    );
  }
}
export default App;
