import { combineReducers } from 'redux'
import todos from './todos'
import counter from './counter'
import transactions from './transactions'
import modals from './modals'
import user from './user'

export default combineReducers({
  todos,
  counter,
  transactions,
  modals,
  user,
})
