postgres:
	docker run --name postgres12 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=root -p 5432:5432 -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root email_verif

dropdb:
	docker exec -it postgres12 dropdb email_verif

migrateup:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/email_verif?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/email_verif?sslmode=disable" -verbose down
	
sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test server