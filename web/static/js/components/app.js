import React, { Component, PropTypes } from 'react'
import Transaction from './transaction';
import {
  addTransaction,
  createTransaction,
  fetchTransactions,
  fetchUser
} from '../actionsCreators';
import { connect } from 'react-redux';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {amount: 0, to: ""};
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
    let amount = parseFloat(this.state.amount) * 10000;
    e.preventDefault()
    fetch(`/api/users/${this.state.to}`)
      .then(response => response.json())
      .then(json => {
        let transaction = {}
        transaction.to_public_key = json.public_key
        transaction.to_address=`${this.state.to}$mason.money`
        transaction.from_public_key = this.props.user.public_key
        transaction.amount = amount;
        this.props.createTransaction(transaction)
      })
    this.setState({amount:"", to:""})
  }

  render() {
    console.log(this.state)
    let transactions = [];
    this.props.transactions.reverse().forEach((transaction, index) => {
    transactions.push(<Transaction key={index} amount={transaction.amount/10000} to={transaction.to_address} from={transaction.from_address}  />)
    })
    return (
    <div>
      <form onSubmit={this.createTransaction.bind(this)} >
      <label>Pay to:</label>
      <input  value={this.state.to} onChange={this.toChanged.bind(this)} />
      <br />
      <label>Amount</label>
      <input  value={this.state.amount} onChange={this.amountChanged.bind(this)} />
      <button onClick={this.createTransaction.bind(this)}>
        Pay
      </button>
      </form>
      {transactions}
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
    addTransaction: (params) => dispatch(addTransaction(params)),
    createTransaction: (params) => dispatch(createTransaction(params))
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(App);
