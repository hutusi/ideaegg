# Users

## List users

Get a list of users by the authenticated user.

```
GET /users
```

Parameters:

- None

```json
[
  {
    "id": 1,
    "username": "john_smith",
    "email": "john@example.com",
    "fullname": "john_smith",
    "created_at": "2013-09-30T13: 46: 02Z",
    "updated_at": "2013-09-30T13: 46: 02Z"
  },
  {
    "id": 2,
    "username": "tom_white",
    "email": "tom@example.com",
    "fullname": "tom_white",
    "created_at": "2013-09-30T13: 46: 02Z",
    "updated_at": "2013-09-30T13: 46: 02Z"
  }
]
```

## Get single user

Get a specific user, identified by idea ID.

```
GET /users/:id
```

Parameters:

- `id` (required) - The ID of a user

```json
{
  "id": 1,
  "username": "john_smith",
  "email": "john@example.com",
  "fullname": "john_smith",
  "created_at": "2013-09-30T13: 46: 02Z",
  "updated_at": "2013-09-30T13: 46: 02Z"
}
```

## Update user

Update a user's username, fullname or email by the authenticated user.

```
PUT /users/:id
```

Parameters:

- `id` (required) - The ID of a user
- `username` (optional) - new username
- `fullname` (optional) - new fullname
- `email` (optional) - new email

## Follow user

Follow another user by the authenticated user.

```
POST /users/:id/follow
```

Parameters:

- `id` (required) - The ID of a user

## Unfollow user

Unfollow another user by the authenticated user.

```
DELETE /users/:id/follow
```

Parameters:

- `id` (required) - The ID of a user
