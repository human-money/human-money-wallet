export default function transactions(state = [], action) {
  switch (action.type) {
    case 'ADD_TRANSACTION':
      return state.concat([{
        from: action.from,
        to: action.to,
        amount: action.amount,
      }])
    case 'RECIEVE_TRANSACTIONS':
      return state.concat(action.transactions)
    default:
      return state
  }
}
