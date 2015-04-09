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
    "avatar" : "http://qiniu.com/xxx",
    "level" : 0,
    "money" : 0,
    "ideas_count" : 0,
    "comments_count" : 0,
    "followees_count" : 0, 
    "followers_count" : 0, 
    "liked_ideas_count" : 0
  },
  {
    ...
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
  "fullname": "john_smith",
  "avatar" : "http://qiniu.com/xxx",
  "level" : 0,
  "money" : 0,
  "ideas_count" : 0,
  "comments_count" : 0,
  "followees_count" : 0, 
  "followers_count" : 0, 
  "liked_ideas_count" : 0,
  "email": "john@example.com",
  "phone_number" : "13800000000", 
  "sign_up_type" : "wechat", // wechat or web
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
- `wechat_openid` (optional) - wechat openid
- `level` (optional) - user level, default is 0
- `money` (optional) - user money, default is 0
- `phone_number` (optional) - phone number
- `avatar` (optional) - avatar url

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

## Get my ideas

Get current user's ideas.

```
GET /my/ideas
```

Parameters:

- None

## Get my liked ideas

Get current user's liked ideas.

```
GET /my/liked_ideas
```

Parameters:

- None

## Get my starred ideas

Get current user's starred ideas.

```
GET /my/starred_ideas
```

Parameters:

- None
