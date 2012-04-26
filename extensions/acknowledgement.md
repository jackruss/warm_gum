## Acknowledgement

### Metadata

    {
      "metadata": {
        "participation": {
          "acknowledged": [2,3,4],
        }
      }
    }

### Routes

#### Acknowledged

return all acknowledged messages

    GET /acknowledged

#### Unacknowledged

return all unacknowledged messages

    GET /unacknowledged

#### Acknowledge

acknowledge a message (adds the user's id to
metadata.participation.acknowledged)

    PUT /acknowledge
