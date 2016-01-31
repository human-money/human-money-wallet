export default function errors(state = [], action) {
  switch (action.type) {
    case 'RECIEVE_ERRORS':
      return state.concat(action.errors)
    default:
      return state
  }
}
