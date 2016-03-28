import _ from 'lodash';
import React, { Component, PropTypes } from 'react'
import Transaction from './transaction';
import Modal from './Modal';
import {
  addTransaction,
  createTransaction,
  fetchTransactions,
  fetchUser,
  openModal,
  closeModal,
} from '../actionsCreators';
import { connect } from 'react-redux';

class Ledger extends Component {
  constructor(props) {
    super(props);
    this.state = {amount: "", to: ""};
  }

  componentDidMount() {
    this.props.fetchUser();
    this.props.fetchTransactions();
  }

  amountChanged(event) {
    this.setState({amount: event.target.value});
  }

  toChanged(event) {
    this.setState({to: event.target.value});
  }

  createTransaction(e){
    e.preventDefault()

    let amount = parseFloat(this.state.amount) * 10000;
    let to = this.state.to;

    var z = this.props.createTransaction({
      to: to,
      amount: amount
    })

    this.setState({amount:"", to:""})
  }

  balance() {
    let bal = _.sumBy(this.props.transactions, (transaction) => {
      if(transaction.to_public_key == this.props.user.public_key) {
        return (transaction.amount / 10000);
      } else {
        return -((transaction.amount / 10000)+0.001);
      }
    });

    if(bal){
      return bal.toFixed(2)
    }
  }

  render() {
    let transactions = [];
    this.props.transactions.forEach((transaction, index) => {
    transactions.push(<Transaction key={transaction.id} amount={transaction.amount/10000} to={transaction.to_address} from={transaction.from_address}  createdAt={transaction.inserted_at} />)
    })
    return (
    <div className="inner">
      <header className="header">
        <div className="logo">MM</div>
        <nav>
          <a href="/auth/sign_out">Sign Out <i className="fa fa-sign-out"></i></a>
        </nav>
      </header>
      <div className="main">
        <div className="sidebar">
          <button onClick={(e) => this.props.openModal("pay")}>
            Send Money
          </button>
          <button onClick={(e) => this.props.openModal("request")}>
            Request Money
          </button>
          <div className="balance"><strong>Balance</strong> ${this.balance()}</div>
        </div>
        <div className="content">
          <h1>Transactions</h1>
          <ol className="transactions">
            {transactions}
          </ol>
        </div>
      </div>
      <Modal title="Send Money" id="pay">
        <form onSubmit={this.createTransaction.bind(this)} >
          <label>Pay to:</label>
          <input  placeholder="Username, etc..." value={this.state.to} onChange={this.toChanged.bind(this)} />
          <span>Username, @twitter_handle, Email, Phone or Mason Money Address</span>
          <br />
          <label>Amount</label>
          <input  placeholder="0.00" value={this.state.amount} onChange={this.amountChanged.bind(this)} />
          <button onClick={this.createTransaction.bind(this)}>
            Send
          </button>
        </form>
     </Modal>
     <Modal title="Request Money" id="request">
     </Modal>
    </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    transactions: state.transactions,
    user: state.user
  }
}

function mapDispatchToProps(dispatch) {
  return {
    fetchUser: () => dispatch(fetchUser()),
    fetchTransactions: () => dispatch(fetchTransactions()),
    // fetch(`/api/users/${to}`)
    //   .then(response => response.json())
    //   .then(json => {
    //     let transaction = {}
    //     transaction.to_public_key = json.public_key
    //     transaction.to_address=`${to}$mason.money`
    //     transaction.from_public_key = this.props.user.public_key
    //     transaction.from_address = `${this.props.user.username}$mason.money`
    //     transaction.amount = amount;
    //     this.props.closeModal('pay')
    //     this.props.createTransaction(transaction)
    //   })
    addTransaction: (params) => dispatch(addTransaction(params)),
    createTransaction: (params) => dispatch(createTransaction(params)),
    openModal: (params) => dispatch(openModal(params)),
    closeModal: (params) => dispatch(closeModal(params))
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Ledger);
