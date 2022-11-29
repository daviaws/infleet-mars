import React, { Component } from "react";

import { Card, Row, Col } from 'react-bootstrap';

export default class Moldure extends Component {

  render() {
    const slot = this.props.slot;
    return (
      <Row>
        <Col sm="3"></Col>
        <Col sm="6">
          <Card>
            <Card.Body>
              {slot}
            </Card.Body>
          </Card>
        </Col>
        <Col sm="3"></Col>
      </Row>
    );
  }

}