import {Socket} from "deps/phoenix/web/static/js/phoenix"
import store from "./store";
import {addTransaction} from "./actionsCreators";
import $ from 'jquery';

let server = $('meta[property="mason_money_node_address"]').attr('content');
let socket = new Socket(`${server}/socket`, {params: {token: window.userToken}})

socket.connect()

let channel = socket.channel("transactions:*", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })
  channel.on("new:transaction", resp => {store.dispatch(addTransaction(resp))})
export default socket
