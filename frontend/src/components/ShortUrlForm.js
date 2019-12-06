import React from 'react';
import {CopyToClipboard} from 'react-copy-to-clipboard';

export default class ShortUrlForm extends React.Component {
  render() {
    const { link } = this.props;

    return (
      <div>
        <label>
          Your shortened URL:
          <br />
        </label>
        <input readOnly value={link}/>
        <CopyToClipboard text={link}>
          <button>Copy URL</button>
        </CopyToClipboard>   
      </div>
    );
  }
}