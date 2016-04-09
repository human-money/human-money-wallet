import ProtoBuf from 'protobufjs';
import nacl from 'tweetnacl';
import request from './request';
import $ from 'jquery';

let server = $('meta[property="mason_money_node_address"]').attr('content');
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
    request(`/api/transactions`,
      {
        method: "post",
        credentials: 'same-origin',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(params)
    }).then((stuff) => {
      dispatch(closeModal('pay'))
    })
  };
}


function addTransaction(params) {
  return Object.assign(params, {
    type: 'ADD_TRANSACTION',
  })
}

function receiveErrors(errors) {
  return {
    type: 'RECIEVE_ERRORS',
    errors
  }
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
    return request(
      `/api/transactions`,
      {
        credentials: 'same-origin'
      }
      )
      .then(json => dispatch(receiveTransactions(json.transactions)))
  }
}

function fetchUser() {
  return dispatch => {
    return request(`/api/current_user`, {credentials: 'same-origin'})
      .then(json => dispatch(receiveUser(json)))
  }
}
export {
  increment,
  addTransaction,
  receiveErrors,
  createTransaction,
  fetchTransactions,
  fetchUser,
  openModal,
  closeModal
};
