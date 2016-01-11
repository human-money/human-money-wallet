import React from 'react';
import Transaction from './transaction';
import { increment } from '../actionsCreators';
import { connect } from 'react-redux';

class App extends React.Component {
  componentDidMount() {
    fetch('http://localhost:4000/transactions')
      .then(function(response){
        return response.json()
    }).then((response) => {
      response.transactions.forEach( (transaction) => {
        console.log(transaction);
      })
     });
  }
  render() {
    return (
    <div>
      <button onClick={this.props.onIncrement}>
        {this.props.value}
      </button>
      <Transaction amount="1.00" from="mason$mason.money" to="bob$mason.money"/>
    </div>
    );
  }
}

function mapStateToProps(state) {
  return {
    value: state.counter
  }
}

function mapDispatchToProps(dispatch) {
  return {
    onIncrement: () => dispatch(increment())
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(App);
