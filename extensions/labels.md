## Labels

### Metadata

    {
      "message" : {
        "metadata": {
          "labels": []
        }
      }
    }

### Routes

#### Messages by label (paginated)

return a paginated list of messages labeled with `:label`

    GET /label/:label

##### Response

* 403 - not authorized  
  body: <blank>  
* 200 - authorized  
  body:

        {
          "messages": [
          ],
          "current_page": 1,
          "per_page": 20,
          "message_count": 21,
        }
