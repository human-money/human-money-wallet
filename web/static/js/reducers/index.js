import { combineReducers } from 'redux'
import counter from './counter'
import error from './errors'
import modals from './modals'
import todos from './todos'
import transactions from './transactions'
import user from './user'

export default combineReducers({
  counter,
  error,
  modals,
  todos,
  transactions,
  user,
})
