package main

import (
	AuthController "chaitham/jwt-api/controller/auth"
	UserController "chaitham/jwt-api/controller/user"
	"chaitham/jwt-api/orm"
	"fmt"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
)

func main() {
	err := godotenv.Load(".env")
	if err != nil {
		fmt.Println("Error loading .env file")
	}

	orm.InitDB()

	r := gin.Default()

	corsConfig := cors.DefaultConfig()
	corsConfig.AllowOrigins = []string{"*"}
	corsConfig.AllowHeaders = []string{"*"}
	r.Use(cors.New(corsConfig))

	r.POST("/login", AuthController.Login)
	r.POST("/users", AuthController.Register)
	r.GET("/users", UserController.ReadAll)
	r.GET("/users/:id", UserController.Profile)
	r.PUT("/users/:id", UserController.Update)
	r.DELETE("/users/:id", UserController.Delete)

	r.Run("localhost:8080")
}
