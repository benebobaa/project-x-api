package main

import (
	"database/sql"
	"log"

	"github.com/benebobaa/project-x-api/api"
	db "github.com/benebobaa/project-x-api/db/sqlc"
	_ "github.com/lib/pq"
)

const (
	dbDriver = "postgres"
	dbSource = "postgresql://root:root@localhost:5432/email_verif?sslmode=disable"
	serverAddress ="0.0.0.0:8000"
)

func main() {
	conn, err := sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(serverAddress)
	if err != nil{
		log.Fatal("cannot start server:", err)
	}
}