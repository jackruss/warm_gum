## Labels

### Metadata

    {
      "metadata": {
        "labels": []
      }
    }

### Routes

#### Messages by label (paginated)

GET `/label/:label`

##### Behavior

All messages containing the label `:label` for the current user

##### Required arguments

None

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
