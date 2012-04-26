## Inbox Extension

### Metadata

    {
      "metadata": {
        "participation": {
          "archived": [4,6,12],
        }
      }
    }

### Routes

#### Inbox (paginated)

GET `/inbox`

##### Behavior

All messages where `to` matches the current user's id

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

### Archive

PUT `/archive`

### Archived

GET `/archived`

