import React, { Component }from 'react'

export default class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      originalUrl: '',
      shortUrl:''
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
    return (
      <div>
        <form onSubmit={this.handleSubmit}>
          <label>
            Input the URL to be shortened:
            <br />
            <input 
              type="text"
              value={this.state.originalUrl}
              onChange={this.handleChange}
            />
          </label>
          <input type="submit" value="Submit" />
        </form>
      </div>
    );
  }
}