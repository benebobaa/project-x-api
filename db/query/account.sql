-- name: CreateAccount :one
INSERT INTO users(
    name,
    email,
    password
) VALUES(
    $1,$2,$3
) RETURNING *;

-- name: GetAccount :one
SELECT * FROM users 
WHERE id = $1 LIMIT 1;

-- name: ListAccounts :many
SELECT * FROM users
ORDER BY id
LIMIT $1
OFFSET $2;

-- name: UpdateAccount :one
UPDATE users SET
    name = $2,
    email = $3
WHERE id = $1
RETURNING *;

-- name: DeleteAccount :exec
DELETE FROM users
WHERE id = $1;