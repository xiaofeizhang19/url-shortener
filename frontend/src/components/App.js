import React, { Component }from 'react'

export default class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      originalUrl: '',
      shortUrl:''
    }
  }

  render() {
    return (
      <div>
        <form>
          <label>
            Input the URL to be shortened:
            <br />
            <input 
              type="text"
              value={this.state.originalUrl}
            />
          </label>
          <input type="submit" value="Submit" />
        </form>
      </div>
    );
  }
}