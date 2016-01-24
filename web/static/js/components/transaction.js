import moment from 'moment';
import React from 'react';

export default class Transaction extends React.Component {
  render() {
    if(this.props.from) {
      return (
      <li className="debit">
        <i className="fa fa-arrow-circle-left"></i>
        <strong> paid </strong>
        <span> {this.props.to} </span>
        <strong>${this.props.amount.toFixed(2)}</strong>
        <span className="date">{moment(this.props.createdAt).fromNow()}</span>
      </li>
      );
    } else {
      return (
      <li className="credit">
        <i className="fa fa-arrow-circle-right"></i>
        <strong> minted </strong>
        <strong>${this.props.amount}</strong>
        <span className="date">{moment(this.props.createdAt).fromNow()}</span>
      </li>
      );
    }
  }
}
