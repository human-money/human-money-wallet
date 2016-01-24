export default function transactions(state = [], action) {
  switch (action.type) {
    case 'ADD_TRANSACTION':
      return [action.transaction].concat(state)
    case 'RECIEVE_TRANSACTIONS':
      return state.concat(action.transactions)
    default:
      return state
  }
}
