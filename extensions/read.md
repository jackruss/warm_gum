## Read

### Metadata

    {
      "metadata": {
        "participation": {
          "read": [4,1,6],
        }
      }
    }

### Routes

#### Mark a message as read

PUT `/:id`

##### Required arguments

* `id`

##### Response

* 403 - not authorized  
  body: <blank>  
* 200 - authorized  
  body: entire message json object

##### Authorization

Current user must be included in one of the following:

* `to`
