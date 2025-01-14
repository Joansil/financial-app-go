package main

import (
    "financial-app/pkg/loan"
    "github.com/gin-gonic/gin"
    "net/http"
)

func main() {
    router := gin.Default()

    router.POST("/loan/apply", func(c *gin.Context) {
        userID := c.PostForm("user_id")
        amount := c.DefaultPostForm("amount", "1000")
        rate := c.DefaultPostForm("rate", "1.5")
        loan := loan.CriarEmpréstimo(userID, amount, rate)
        c.JSON(http.StatusOK, loan)
    })

    router.GET("/loan/{userID}", func(c *gin.Context) {
        userID := c.Param("userID")
        loans := loan.ObterEmpréstimos(userID)
        c.JSON(http.StatusOK, loans)
    })

    router.Run(":8082")
}
