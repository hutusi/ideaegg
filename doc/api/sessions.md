# Sessions

## Sign up

Sign up to register new user

```
POST /sign_up
```

Parameters:

- `username` (required) - The username of user
- `email` (required) - The email of user
- `password` (required) - User password
- `password_confirmation` (required) - User password confirmation


```json
{
  "id": 1,
  "username": "john_smith",
  "email": "john@example.com",
  "fullname": "john_smith",
  "private_token": "dd34asd13as",
  "created_at": "2012-05-23T08:00:58Z"
}
```

## Sign in

Sign in to get private token

```
POST /sign_in
```

Parameters:

- `login` (required) - The login of user: username or email
- `password` (required) - Valid password

```json
{
  "id": 1,
  "username": "john_smith",
  "email": "john@example.com",
  "fullname": "john_smith",
  "private_token": "dd34asd13as",
  "created_at": "2012-05-23T08:00:58Z"
}
```
