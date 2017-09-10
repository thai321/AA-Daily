import React from 'react';

import Clock from './clock';
import Weather from './weather';
import Autocomplete from './autocomplete';
import Tab from './tab';

const Names = [
  'Abba',
  'Barney',
  'Barbara',
  'Jeff',
  'Jenny',
  'Sarah',
  'Sally',
  'Xander'
];

const Tabs = [
  { title: 'one', content: 'I am the first' },
  { title: 'two', content: 'I am the second' },
  { title: 'three', content: 'I am the third' }
];

class App extends React.Component {
  render() {
    return (
      <div>
        <Clock />
        <Weather />
        <Autocomplete names={Names} />
        <Tab tabs={Tabs} />
      </div>
    );
  }
}
export default App;
