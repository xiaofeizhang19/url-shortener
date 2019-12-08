import React, { Component }from 'react';
import { Navbar } from 'react-bootstrap';

export default class Header extends Component {
  render() {
    return (
      <div>
        <Navbar expand="lg" variant="light" bg="light">
          <Navbar.Brand href="/">URL Shortener</Navbar.Brand>
        </Navbar>
      </div>
    )
  }
  }