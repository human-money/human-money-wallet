import React from 'react';

export default class Transaction extends React.Component {
  render() {
    return (
    <div>
    <span>{this.props.from}</span>
    <strong> paid </strong>
    <span>{this.props.to}</span>
    <strong> ${this.props.amount}</strong>
  </div>
    );
  }
}
