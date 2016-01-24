function request(...args){
  return fetch(...args)
      .then(json => dispatch(receiveTransactions(json.transactions)))
}

export default request;
