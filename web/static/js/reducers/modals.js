export default function modals(state = {}, action) {
  switch (action.type) {
    case 'OPEN_MODAL':
      var newState = {};
      newState[action.target] = true;
      return Object.assign({}, state, newState);
    case 'CLOSE_MODAL':
      var newState = {};
      newState[action.target] = false;
      return Object.assign({}, state, newState);
    default:
      return state;
  }
}
