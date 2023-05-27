import React from "react";
import PropTypes from "prop-types";

import "./Display.css";

export default class Display extends React.Component {
  static propTypes = {
    value: PropTypes.string,
  };

  render() {
    return (
      <div className="component-display">
        <h3>Welcome to DevOps Course by Cloud Advocate</h3>
        <div>{this.props.value}</div>
      </div>
    );
  }
}
