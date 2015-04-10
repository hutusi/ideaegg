# Tags

## List tags

Get a list of tags by the authenticated user.

Orderred by taggings_count DESC.

```
GET /tags
```

Parameters:

- None

```json
[
  {
    "id": 4,
    "name": "hello",
    "taggings_count": 3
  },
  {
    ...
  }
]
```