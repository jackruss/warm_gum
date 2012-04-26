# Group Addressees

Allow Warm Gum users to send messages to groups of users.

## Configuration

    {
      "groups": {
        "role": {
          "name": "Roles",
          "key": "roles"
        },
        "sponsor": {
          "name": "Sponsors",
          "key": "sponsors"
        },
        "center": {
          "name": "Centers",
          "key": "centers"
        }
      }
    }

## Extended Message Attributes for Group Addressees

    {
      "message": {
        "metadata": {
          "addressees": {
            "groups": {
              "roles": [2,4,6],
              "sponsors": [3,5,6],
              "centers": [1,2,3]
            }
          }
        }
      }
    }

## Group Record JSON Structure

Each group represented in the Warm Gum group recipients extension needs to provide the following data

    {
      "group": {
        "id": 1,
        "type": "sponsor",
        "title": "Life at St. Francis",
        "users": [1,2,3],
        "metadata": {}
      }
    }

## Routes

### About

returns the configuration JSON object

    GET /groups/about

### Single Group

return the group record matching `:type` and `:id`

    GET /group/:type/:id

### Search Groups

return all groups for `:type` containing `:term` in the title

    GET/group/:type/:term




## Group Metadata for a User

a an example User record follows:

    {
      "user": {
        "id": 1,
        "first_name": "Terrible Terry",
        "last_name": "Tate",
        "metadata": {
          "groups": {
            "sponsors": [2,3,4],
            "centers": [4,5,6],
            "roles": [2,5,7]
          }
        }
      }
    }