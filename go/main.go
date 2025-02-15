package main

import (
	"database/sql"
	"fmt"

	_ "github.com/go-sql-driver/mysql"
)

func main() {

	//criar uma conexao com o banco de dados mysql
	db := dbConn()
	defer db.Close()

	sqlStatement := "SELECT * FROM teste"
	rows, err := db.Query(sqlStatement)
	if err != nil {
		fmt.Println(err)
	}
	defer rows.Close()

	for rows.Next() {
		var id int
		var teste string
		var createad_at string
		err = rows.Scan(&id, &teste, &createad_at)
		if err != nil {
			fmt.Println(err)
		}
		fmt.Println(id, teste, createad_at)
	}
}

func dbConn() *sql.DB {
	dbDriver := "mysql"
	dbHost := "127.0.0.1"
	dbUser := "root"
	dbPass := "root"
	dbName := "aws_db"
	db, err := sql.Open(dbDriver, dbUser+":"+dbPass+"@tcp("+dbHost+":3306)/"+dbName)
	if err != nil {
		fmt.Println(err)
	}
	return db
}