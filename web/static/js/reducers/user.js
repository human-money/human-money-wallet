export default function user(state = [], action) {
  switch (action.type) {
    case 'RECIEVE_USER':
      return action.user
    default:
      return state
  }
}
