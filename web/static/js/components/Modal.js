import classNames from 'classnames';
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'
import * as AppActions from '../actionsCreators'
import React, { Component, PropTypes } from 'react';
var _ = require('lodash');

class Modal extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    const { modals, id, closeModal } = this.props;
    const modalClasses = classNames(
      {
        "modal-overlay": true,
        "is-open": modals[id] || false,
      }
    );
    return (
      <div className={modalClasses}>
        <div className="modal">
          <header className="modal-header">
            <h1>{this.props.title}</h1>
            <div className="modal-close" onClick={closeModal.bind(_, id)}>&times;</div>
          </header>
          {this.props.children}
        </div>
      </div>
    );
  }
}

Modal.propTypes = {
  isOpen: PropTypes.bool,
  close: PropTypes.func
}

function mapStateToProps(state) {
    return {
      modals: state.modals,
    }
}

function mapDispatchToProps(dispatch) {
  return bindActionCreators(AppActions, dispatch);
}

export default connect(mapStateToProps, mapDispatchToProps)(Modal);
