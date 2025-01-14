package main

import (
    "financial-app/pkg/transaction"
    "github.com/gin-gonic/gin"
    "net/http"
)

func main() {
    router := gin.Default()

    router.POST("/transaction", func(c *gin.Context) {
        userID := c.PostForm("user_id")
        amount := c.DefaultPostForm("amount", "1000")
        tType := c.DefaultPostForm("type", "credit")
        txn := transaction.CriarTransação(userID, amount, tType)
        c.JSON(http.StatusOK, txn)
    })

    router.GET("/transaction/{userID}", func(c *gin.Context) {
        userID := c.Param("userID")
        transactions := transaction.ObterTransações(userID)
        c.JSON(http.StatusOK, transactions)
    })

    router.Run(":8083")
}
