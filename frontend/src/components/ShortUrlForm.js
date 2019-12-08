import React from 'react';
import {CopyToClipboard} from 'react-copy-to-clipboard';
import Form from 'react-bootstrap/Form';

export default class ShortUrlForm extends React.Component {
  render() {
    const { link } = this.props;

    return (
      <div>
        <Form>
          <Form.Group>
            <Form.Label>
              Your shortened URL:
              <br />
            </Form.Label>
            <Form.Control readOnly value={link}/>
          </Form.Group>
        </Form>
            <CopyToClipboard text={link}>
              <button>Copy URL</button>
            </CopyToClipboard>
      </div>
    );
  }
}