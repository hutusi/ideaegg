# Ideas

## List ideas

Get a list of ideas by the authenticated user.

```
GET /ideas
```

Parameters:

- None

```json
[
  {
    "id": 4,
    "title": "hello",
    "content": "world",
    "public" : true,
    "created_at": "2013-09-30T13: 46: 02Z",
    "updated_at": "2013-09-30T13: 46: 02Z",
    "comments_count": 0, 
    "cached_votes_up": 0, 
    "stars_count": 0,
    "author": {
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

## Get single idea

Get a specific idea, identified by idea ID.

```
GET /ideas/:id
```

Parameters:

- `id` (required) - The ID of an idea

```json
{
  "id": 4,
  "title": "hello",
  "content": "world",
  "public" : true,
  "created_at": "2013-09-30T13: 46: 02Z",
  "updated_at": "2013-09-30T13: 46: 02Z",
  "comments_count": 0, 
  "cached_votes_up": 0, 
  "stars_count": 0,
  "author": {
    "id": 1,
    "username": "john_smith",
    "fullname": "john_smith",
    "avatar": "http://qiniu.com/xxx"
  }
}
```

## Create idea

Creates a new idea owned by the authenticated user.

```
POST /ideas
```

Parameters:

- `title` (required) - new idea title
- `content` (required) - new idea content
- `public` (optional) - true or false
- `level` (optional) - idea's level, default is 0

## Update idea

Update an idea's title or content owned by the authenticated user.

```
PUT /ideas/:id
```

Parameters:

- `id` (required) - The ID of an idea
- `title` (optional) - new title
- `content` (optional) - new content
- `public` (optional) - true or false
- `level` (optional) - idea's level, default is 0

## Delete idea

Delete an idea owned by the authenticated user.

```
DELETE /ideas/:id
```

Parameters:

- `id` (required) - The ID of an idea

## Like idea

Like an idea by the authenticated user.

```
POST /ideas/:id/like
```

Parameters:

- `id` (required) - The ID of an idea

## Unlike idea

Unlike an idea by the authenticated user.

```
DELETE /ideas/:id/like
```

Parameters:

- `id` (required) - The ID of an idea

## Star idea

Star an idea by the authenticated user.

```
POST /ideas/:id/star
```

Parameters:

- `id` (required) - The ID of an idea

## Unstar idea

Unstar an idea by the authenticated user.

```
DELETE /ideas/:id/star
```

Parameters:

- `id` (required) - The ID of an idea

## Tag idea

Tag an idea by the authenticated user.

```
PUT /ideas/:id/tag
```

Parameters:

- `id` (required) - The ID of an idea
- `tag` (required) - tags, splitted by ',' such as 'software' or 'software, children'

## Untag idea

Untag an idea by the authenticated user.

```
PUT /ideas/:id/untag
```

Parameters:

- `id` (required) - The ID of an idea
- `tag` (required) - tags, splitted by ',' such as 'software' or 'software, children'
