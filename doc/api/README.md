# Ideaegg API

## Introduction

All API requests require authentication. You need to pass a `private_token` parameter by URL or header. If passed as header, the header name must be "PRIVATE-TOKEN" (capital and with dash instead of underscore). You can find or reset your private token in your profile.

If no, or an invalid, `private_token` is provided then an error message will be returned with status code 401:

```json
{
  "message": "401 Unauthorized"
}
```

API requests should be prefixed with `api` and the API version. The API version is defined in `lib/api.rb`.

Example of a valid API request:

```
GET http://ideaegg.me/api/v1/ideas?private_token=QVy1PB7sTxfy4pqfZM1U
```

Example for a valid API request using curl and authentication via header:

```
curl --header "PRIVATE-TOKEN: QVy1PB7sTxfy4pqfZM1U" "http://ideaegg.me/api/v1/ideas"
```

The API uses JSON to serialize data. You don't need to specify `.json` at the end of API URL.

## Status codes

The API is designed to return different status codes according to context and action. In this way if a request results in an error the caller is able to get insight into what went wrong, e.g. status code `400 Bad Request` is returned if a required attribute is missing from the request. The following list gives an overview of how the API functions generally behave.

API request types:

- `GET` requests access one or more resources and return the result as JSON
- `POST` requests return `201 Created` if the resource is successfully created and return the newly created resource as JSON
- `GET`, `PUT` and `DELETE` return `200 OK` if the resource is accessed, modified or deleted successfully, the (modified) result is returned as JSON
- `DELETE` requests are designed to be idempotent, meaning a request a resource still returns `200 OK` even it was deleted before or is not available. The reasoning behind it is the user is not really interested if the resource existed before or not.

The following list shows the possible return codes for API requests.

Return values:

- `200 OK` - The `GET`, `PUT` or `DELETE` request was successful, the resource(s) itself is returned as JSON
- `201 Created` - The `POST` request was successful and the resource is returned as JSON
- `400 Bad Request` - A required attribute of the API request is missing, e.g. the title of an issue is not given
- `401 Unauthorized` - The user is not authenticated, a valid user token is necessary, see above
- `403 Forbidden` - The request is not allowed, e.g. the user is not allowed to delete a project
- `404 Not Found` - A resource could not be accessed, e.g. an ID for a resource could not be found
- `405 Method Not Allowed` - The request is not supported
- `409 Conflict` - A conflicting resource already exists, e.g. creating a project with a name that already exists
- `422 Unprocessable` - The entity could not be processed
- `500 Server Error` - While handling the request something went wrong on the server side

## Pagination

When listing resources you can pass the following parameters:

- `page` (default: `1`) - page number
- `per_page` (default: `20`, max: `100`) - number of items to list per page

[Link headers](http://www.w3.org/wiki/LinkHeader) are send back with each response. These have `rel` prev/next/first/last and contain the relevant URL. Please use these instead of generating your own urls.

## Data validation and error reporting

When working with the API you may encounter validation errors. In such case, the API will answer with an HTTP `400` status.
Such errors appear in two cases:

* A required attribute of the API request is missing, e.g. the title of an issue is not given
* An attribute did not pass the validation, e.g. user bio is too long

When an attribute is missing, you will get something like:

HTTP/1.1 400 Bad Request
Content-Type: application/json

{
  "message":"400 (Bad request) \"title\" not given"
}

When a validation error occurs, error messages will be different. They will hold all details of validation errors:

HTTP/1.1 400 Bad Request
Content-Type: application/json

{
  "message": {
    "bio": [
    "is too long (maximum is 255 characters)"
    ]
  }
}

This makes error messages more machine-readable. The format can be described as follow:

{
  "message": {
    "<property-name>": [
    "<error-message>",
    "<error-message>",
    ...
    ],
    "<embed-entity>": {
      "<property-name>": [
      "<error-message>",
      "<error-message>",
      ...
      ],
    }
  }
}
