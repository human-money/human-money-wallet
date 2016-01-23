import React, { Component, PropTypes } from 'react';

class Button extends React.Component {
  render() {
    const { onClick } = this.props;
    var styles = {};
    styles.borderColor = this.props.borderColor;
    return (
      <button className="button" onClick={onClick} style={styles}>
        {this.props.title}
      </button>);
  }
}

Button.propTypes = {
  onClick: PropTypes.func,
  title: PropTypes.string.isRequired,
  borderColor: PropTypes.string,
}


export default Button;
