function increment() {
  return {
    type: 'INCREMENT',
  }
}

function addTransaction(params) {
  return Object.assign(params, {
    type: 'ADD_TRANSACTION',
  })
}

function receiveTransactions(transactions) {
  return {
    type: 'RECIEVE_TRANSACTIONS',
    transactions
  }
}

function fetchTransactions() {
  return dispatch => {
    return fetch(`http://localhost:4000/transactions`)
      .then(response => response.json())
      .then(json => dispatch(receiveTransactions(json.transactions)))
  }
}

export {increment, addTransaction, fetchTransactions};
