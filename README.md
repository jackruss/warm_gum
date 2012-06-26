# Warm Gum

## External Data Requirements

A Warm Gum instance requires the following information from the application with which it integrates:

## Message Record JSON Structure

    {
      "message": {
        "id": 1234,
        "sent_at": "2012/04/23",
        "subject": "Get ready for messaging v2",
        "from": 2,
        "body": "this is a hot body.",
        "metadata": {}
      }
    }

## Routes

### Current User

return the JSON representation of the currently logged in user

    GET /user

#### Structure

    {
      "user": {
        "id": 1,
        "first_name": "Terrible Terry",
        "last_name": "Tate",
        "metadata": {}
      }
    }

### Create a message

create a new message with the required arguments, optional arguments
and derived values set appropriately, all metadata is stored as is.

    POST /messages

#### Required arguments

* `subject`

#### Optional arguments

* `body`

#### Derived values

* `from` - `current_user.id` in the session

#### Response

* 403 - not authorized  
  body: <blank>  
* 200 - authorized and message was created, body: entire preprocessed JSON
message  
  body: entire message json object


### Deliver a message

deliver a message, i.e. set delivered_at, set state to delivered

    PUT /messages/:id/deliver

#### Required arguments

none

#### Optional arguments

none

#### Derived values

* `delivered_at`- current time
* `state` - 'delivered'

#### Response

* 403 - not authorized  
  body: <blank>  
* 200 - message was delivered  
  body: entire message json object

### List all messages (paginated)

All messages where current user is included in one of the following:

* `to`
* `from`

    GET /

#### Required arguments

None

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

### Retrieve a message

GET `/message/:id`

#### Required arguments

* `id`

#### Response

* 403 - not authorized  
  body: <blank>  
* 200 - authorized  
  body: entire message json object

#### Authorization

Current user must be included in one of the following:

* `from`
* `metadata.addressees.individuals`
* user's groups must intersect with `metadata.addressees.groups`

### Sent messages (paginated)

All messages where `from` matches the current user's id

    GET /sent

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
