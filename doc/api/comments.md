# Comments

## List comments

Get a list of comments of an idea.

```
GET /ideas/:id/comments
```

Parameters:

- None

```json
[
  {
    "id": 4,
    "body": "this is a comment",
    "created_at": "2013-09-30T13: 46: 02Z",
    "updated_at": "2013-09-30T13: 46: 02Z",
    "commentator": {
      "id": 1,
      "username": "john_smith",
      "fullname": "john_smith",
      "avatar": "http://qiniu.com/xxx"
    }
  },
  {
    ...
  }
]
```

## Create comment

Creates a new comment to an idea.

```
POST /ideas/:id/comments
```

Parameters:

- `body` (required) - new comment body

## Delete comment

Delete a comment.

```
DELETE /comments/:id
```

Parameters:

- `id` (required) - The ID of a comment