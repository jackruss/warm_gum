# Individual User Addressees Extension

Allow Warm Gum users to send messages to individuals.

## Participant Record JSON Structure

    {
      "user": {
        "id": 1,
        "first_name": "Terrible Terry",
        "last_name": "Tate",
        "metadata": {}
      }
    }

## Extended Message Metadata

    {
      "message": {
        "metadata": {
          "addressees": {
            "individuals": [2,3,4]
          }
        }
      }
    }

## Routes

### Individual User

returns a the user matching `:id`

    GET /users/:id

### Search Users

returns a list of participants whose first name or last name contains `:term`

    GET /users/search/:term
