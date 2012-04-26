## Search

### Routes

#### Search (paginated)

GET `/search/:term`

##### Behavior

Return a paginated list of messages accessible by the current user for
which the subject or body contains the search term

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
