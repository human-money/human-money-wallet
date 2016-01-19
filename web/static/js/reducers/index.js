import { combineReducers } from 'redux'
import todos from './todos'
import counter from './counter'
import transactions from './transactions'
import user from './user'

export default combineReducers({
  todos,
  counter,
  transactions,
  user,
})
