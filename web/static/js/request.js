import store from 'store';
import { receiveErrors } from './actionsCreators';

function parseJSON(response){
  return response.json().then(json => {
    if(response.ok) {
      return json
    } else {
      return Promise.reject(json);
    }
  });
}

function onError(error) {
  store.dispatch(receiveErrors(error));
}

function request(...args){
  return fetch(...args)
    .then(parseJSON)
    .catch(onError);
}

export default request;
