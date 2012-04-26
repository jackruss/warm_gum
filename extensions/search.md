# Search

## Routes

### Search (paginated)

Return a paginated list of messages accessible by the current user for
which the subject or body contains the search term

    GET /search/:term

#### Response

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
