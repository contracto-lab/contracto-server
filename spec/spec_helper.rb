require_relative '../lib/contracto'

STRINGS_WITH_JSON = []
STRINGS_WITH_JSON << <<JSON
{
  "request": {
    "http_method": "get",
    "path": "/api/users"
  },
  "examples": [
    {
      "request": {
        "headers": {
          "Content-Type": "application/json"
        },
        "body": {
          "firstName": "Max",
          "lastName": "Lincoln"
        }
      },
      "response": {
        "body": { }
      }
    }
  ]
}
JSON

STRINGS_WITH_JSON << <<JSON
{
  "request": {
    "http_method": "get",
    "path": "/api/users/:id"
  },
  "examples": [
    {
      "request": {
        "headers": {
          "Content-Type": "application/json"
        },
        "body": {
          "firstName": "Max",
          "lastName": "Lincoln"
        }
      },
      "response": {
        "body": { }
      }
    }
  ]
}
JSON
