import ProtoBuf from 'protobufjs';
import nacl from 'tweetnacl';

export function openModal(target) {
  return {
    type: 'OPEN_MODAL',
    target: target,
  }
}

export function closeModal(target) {
  return {
    type: 'CLOSE_MODAL',
    target: target,
  }
}

function increment() {
  return {
    type: 'INCREMENT',
  }
}

function createTransaction(params) {
  return (dispatch, getState) => {
    ProtoBuf.loadProtoFile("/mason_money.proto", function(err, builder) {
      builder.build()
      let Transaction = builder.result.protobufs.Transaction
      let t = new Uint8Array((new Transaction(params)).encode().buffer);

      params.signature = nacl.util.encodeBase64(nacl.sign.detached(t,
        new TextEncoder('utf-8').encode(getState().user.private_key)
        ));
      fetch('http://localhost:4000/transactions',
        {
          method: "post",
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(params)
        });
    });
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

function receiveUser(user) {
  return {
    type: 'RECIEVE_USER',
    user
  }
}

function fetchTransactions() {
  return dispatch => {
    return fetch(`http://localhost:4000/transactions`)
      .then(response => response.json())
      .then(json => dispatch(receiveTransactions(json.transactions)))
  }
}

function fetchUser() {
  return dispatch => {
    return fetch(`/api/current_user`, {credentials: 'same-origin'})
      .then(response => response.json())
      .then(json => dispatch(receiveUser(json)))
  }
}
export {
  increment,
  addTransaction,
  createTransaction,
  fetchTransactions,
  fetchUser,
  openModal,
  closeModal
};
