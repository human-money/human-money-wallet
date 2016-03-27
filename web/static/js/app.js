import Socket from "./socket"


import React from 'react';
import ReactDOM from 'react-dom';
import { Router, Route, Link, browserHistory } from 'react-router'
import Ledger from './components/ledger';
import NotFound from './components/not_found'
import { Provider } from 'react-redux'
import store from './store';


ReactDOM.render(
<Provider store={store}>
  <Router history={browserHistory}>
    <Route path="/">
      <Route path="transactions" component={Ledger}/>
      <Route path="*" component={NotFound}/>
    </Route>
  </Router>
</Provider>
, document.getElementById("root"));

