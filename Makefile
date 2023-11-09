postgres:
	docker run --name postgres12 --network bene-network -e POSTGRES_USER=root -e POSTGRES_PASSWORD=root -p 5432:5432 -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root email_verif

dropdb:
	docker exec -it postgres12 dropdb email_verif

migrateup:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/email_verif?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/email_verif?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/email_verif?sslmode=disable" -verbose down
	
migratedown1:
	migrate -path db/migration -database "postgresql://root:root@localhost:5432/email_verif?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

# helper:
# 	docker run --name simple_x --network bene-network -p 8080:8080 -e GIN_MODE=release -e DB_SOURCE="postgresql://root:root@postgres12:5432/email_verif?sslmode=disable" simple_x:latest

.PHONY: postgres createdb dropdb migrateup migratedown migrateup1 migratedown1 sqlc test server