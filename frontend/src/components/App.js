import React, { Component }from 'react';
import Header from './Header.js';
import ShortUrlForm from './ShortUrlForm';
import Form from 'react-bootstrap/Form';
import Button from 'react-bootstrap/Button';

export default class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      originalUrl: '',
      shortUrl: '',
    }

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
  }

  handleChange = (event) => {
    this.setState({originalUrl: event.target.value})
  }

  handleSubmit = (event) => {
    event.preventDefault();
    const { originalUrl } = this.state;
    fetch('http://localhost:4567', {
      method: 'POST',
      body: JSON.stringify({url: originalUrl})
    })
      .then(response => response.json())
      .then(data => {this.setState({shortUrl: data.short_url})})
      .catch(error => alert(error));
  }

  render() {
    const { shortUrl } = this.state;

    let shortUrlForm;
    if (shortUrl !== "") {
      const link = `http://localhost:4567${shortUrl}`;
      shortUrlForm = <ShortUrlForm link={link} />;
    }

    return (
      <>
        <Header />
        <div className="container">
          <br />
          <Form onSubmit={this.handleSubmit}>
            <Form.Group>
              <Form.Label>
                Input the URL to be shortened:
                <br />
              </Form.Label>
              <Form.Control
                type="text"
                value={this.state.originalUrl}
                onChange={this.handleChange}
              />
              <Button variant="secondary" type="submit">
                Shorten URL
              </Button>
            </Form.Group>
          </Form>
          {shortUrlForm}
        </div>
      </>
    )
  }
}