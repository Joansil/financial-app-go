package main

import (
	"financial-app/pkg/auth"
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	router := gin.Default()

	router.POST("/auth/login", func(c *gin.Context) {
		userID := c.PostForm("user_id")
		token, err := auth.GenerateJWT(userID)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
		c.JSON(http.StatusOK, gin.H{"token": token})
	})

	router.Run(":8081")
}
