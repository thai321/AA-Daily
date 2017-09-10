import React from 'react';

class Tab extends React.Component {
  constructor(props) {
    super(props);

    this.state = { selected: 0 };

    this.selectTab = this.selectTab.bind(this);
  }

  titles() {
    return this.props.tabs.map((tab, index) =>
      <li
        key={tab.title}
        onClick={this.selectTab}
        data={index}
        className={index === this.state.selected ? 'active' : ''}
      >
        {tab.title}
      </li>
    );
  }

  selectTab(event) {
    const index = parseInt(event.target.getAttribute('data'));
    this.setState({ selected: index });
  }

  content() {
    const content = this.props.tabs[this.state.selected].content;
    return content;
  }

  render() {
    return (
      <div className="tabs">
        <br />
        <h1> Tab Section </h1>

        <ul className="tabs-ul">
          {this.titles()}
        </ul>

        <article className="content">
          {this.content()}
        </article>
      </div>
    );
  }
}

export default Tab;
