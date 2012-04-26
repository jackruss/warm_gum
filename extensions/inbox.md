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

return a paginated list of unarchived messages

    GET /inbox

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

archive the message referred to by `:id`, (add the user's id to the
metadata.participation.archived list)

    PUT /archive/:id

### Archived

return a paginated list of archived messages

    GET /archived
