import React, { Component, PropTypes } from 'react'
import Transaction from './transaction';
import { addTransaction, fetchTransactions } from '../actionsCreators';
import { connect } from 'react-redux';

class App extends Component {
  componentDidMount() {
    this.props.fetchTransactions();
  }

  render() {
    let transactions = [];
    this.props.transactions.forEach((transaction, index) => {
      transactions.push(<Transaction key={index} amount={transaction.amount} to={transaction.to_address} from={transaction.from_address}  />)
    })
    return (
    <div>
      <button onClick={() => this.props.addTransaction({to: "mason", from: "bob", amount: 1})}>
        Add
      </button>
      {transactions}
      <Transaction amount="1.00" from="mason$mason.money" to="bob$mason.money"/>
    </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    transactions: state.transactions
  }
}

function mapDispatchToProps(dispatch) {
  return {
    fetchTransactions: () => dispatch(fetchTransactions()),
    addTransaction: (params) => dispatch(addTransaction(params))
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(App);
