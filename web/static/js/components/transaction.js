import moment from 'moment';
import React from 'react';

export default class Transaction extends React.Component {
  render() {
    if(this.props.source_user_id == this.props.current_user.id) {
      return (
      <li className="debit">
        <i className="fa fa-arrow-circle-left"></i>
        <strong> paid </strong>
        <span> {this.props.destination} </span>
        <strong>${(this.props.amount/10000).toFixed(2)}</strong>
        <span className="date">{moment(this.props.inserted_at).fromNow()}</span>
      </li>
      );
    } else {
      return (
      <li className="credit">
        <i className="fa fa-arrow-circle-right"></i>
        <strong> minted </strong>
        <strong>${(this.props.amount/10000).toFixed(2)}</strong>
        <span className="date">{moment(this.props.inserted_at).fromNow()}</span>
      </li>
      );
    }
  }
}
