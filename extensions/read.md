## Read

### Metadata

    {
      "message" {
        "metadata": {
          "participation": {
            "read": [4,1,6],
          }
        }
      }
    }

### Routes

#### Mark a message as read

mar a message read (add the user's id to the message.participation.read
list)

    PUT /:id

##### Required arguments

* `id`

##### Response

* 403 - not authorized  
  body: <blank>  
* 200 - authorized  
  body: entire message json object
