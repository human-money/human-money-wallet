import React from 'react';

export default class Transaction extends React.Component {
  render() {
    if(this.props.from) {
      return (
      <div>
        <span>{this.props.from}</span>
        <strong> paid </strong>
        <span>{this.props.to}</span>
        <strong> ${this.props.amount}</strong>
      </div>
      );
    } else {
      return (
      <div>
        <span>{this.props.to}</span>
        <strong> minted </strong>
        <strong> ${this.props.amount}</strong>
      </div>
      );
    }
  }
}
