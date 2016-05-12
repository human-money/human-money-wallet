import React, { Component, PropTypes } from 'react'
import { connect } from 'react-redux';
import {
  createAccount,
} from '../actionsCreators';

class Profile extends Component {
  handleUsernameChange(e) {
    this.setState({username: e.target.value});
  }

  render () {
    return (
      <div className="inner">
        <header className="header">
          <div className="logo">MM</div>
        </header>
        <div className="main">
          <div style={{"width": "302px", "margin": "0 auto"}}>
            <form onSubmit={(e) => {e.preventDefault();console.log(this); this.props.createAccount({"username": this.state.username})}} >
            <label htmlFor="username" style={{textAlign: "center", fontSize:"2em"}} >Your Username</label>
            <input style={{width: "inherit", "float": "left"}}  onChange={this.handleUsernameChange.bind(this)} ></input><div style={{float: "left", paddingLeft: "5px", paddingTop: "8px"}}>$mason.money</div>
            <button style={{"float": "right", "clear": "left"}}>Sign Up</button>
            </form>
          </div>
        </div>
      </div>
    )
  }
}

function mapStateToProps(state) {
  return {
  }
}

function mapDispatchToProps(dispatch) {
  return {
    createAccount: (params) => dispatch(createAccount(params))
  }
}

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Profile);
