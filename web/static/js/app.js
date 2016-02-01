import Socket from "./socket"


import React from 'react';
import ReactDOM from 'react-dom';
import Ledger from './components/ledger';
import { Provider } from 'react-redux'

import store from './store';
ReactDOM.render(
<Provider store={store}>
<Ledger />
</Provider>
, document.getElementById("root"));

