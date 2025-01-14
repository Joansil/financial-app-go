#!/bin/bash

# Define o nome do projeto
PROJECT_NAME="financial-app"

# Criação da estrutura principal de diretórios
mkdir -p $PROJECT_NAME/{cmd/{auth-service,loan-service,transaction-service},pkg/{auth,loan,transaction},api/v1,internal,db/migrations,scripts/kafka}

# Criação dos arquivos principais
touch $PROJECT_NAME/Dockerfile
touch $PROJECT_NAME/docker-compose.yml
touch $PROJECT_NAME/go.mod
touch $PROJECT_NAME/go.sum
touch $PROJECT_NAME/README.md

# Criação dos arquivos principais de cada microserviço

# Serviço de autenticação
echo "package main

import (
    \"fmt\"
    \"log\"
    \"net/http\"
    \"financial-app/pkg/auth\"
    \"github.com/gin-gonic/gin\"
)

func main() {
    router := gin.Default()

    router.POST(\"/auth/login\", func(c *gin.Context) {
        userID := c.PostForm(\"user_id\")
        token, err := auth.GenerateJWT(userID)
        if err != nil {
            c.JSON(http.StatusInternalServerError, gin.H{\"error\": err.Error()})
            return
        }
        c.JSON(http.StatusOK, gin.H{\"token\": token})
    })

    router.Run(\":8081\")
}" > $PROJECT_NAME/cmd/auth-service/main.go

# Serviço de empréstimo
echo "package main

import (
    \"financial-app/pkg/loan\"
    \"github.com/gin-gonic/gin\"
    \"net/http\"
)

func main() {
    router := gin.Default()

    router.POST(\"/loan/apply\", func(c *gin.Context) {
        userID := c.PostForm(\"user_id\")
        amount := c.DefaultPostForm(\"amount\", \"1000\")
        rate := c.DefaultPostForm(\"rate\", \"1.5\")
        loan := loan.CriarEmpréstimo(userID, amount, rate)
        c.JSON(http.StatusOK, loan)
    })

    router.GET(\"/loan/{userID}\", func(c *gin.Context) {
        userID := c.Param(\"userID\")
        loans := loan.ObterEmpréstimos(userID)
        c.JSON(http.StatusOK, loans)
    })

    router.Run(\":8082\")
}" > $PROJECT_NAME/cmd/loan-service/main.go

# Serviço de transações
echo "package main

import (
    \"financial-app/pkg/transaction\"
    \"github.com/gin-gonic/gin\"
    \"net/http\"
)

func main() {
    router := gin.Default()

    router.POST(\"/transaction\", func(c *gin.Context) {
        userID := c.PostForm(\"user_id\")
        amount := c.DefaultPostForm(\"amount\", \"1000\")
        tType := c.DefaultPostForm(\"type\", \"credit\")
        txn := transaction.CriarTransação(userID, amount, tType)
        c.JSON(http.StatusOK, txn)
    })

    router.GET(\"/transaction/{userID}\", func(c *gin.Context) {
        userID := c.Param(\"userID\")
        transactions := transaction.ObterTransações(userID)
        c.JSON(http.StatusOK, transactions)
    })

    router.Run(\":8083\")
}" > $PROJECT_NAME/cmd/transaction-service/main.go

# Adicionando o código de Kafka
echo "package kafka

import (
    \"github.com/segmentio/kafka-go\"
    \"log\"
)

var kafkaWriter *kafka.Writer

func InitKafka() {
    kafkaWriter = &kafka.Writer{
        Addr:     kafka.TCP(\"localhost:9093\"),
        Topic:    \"loan-requests\",
        Balancer: &kafka.LeastBytes{},
    }
}

func ProduceMessage(message string) {
    err := kafkaWriter.WriteMessages(nil, kafka.Message{
        Value: []byte(message),
    })
    if err != nil {
        log.Fatalf(\"failed to produce message: %v\", err)
    }
}" > $PROJECT_NAME/pkg/kafka/producer.go

# Criação do arquivo Dockerfile
echo "FROM golang:1.20-alpine

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod tidy

COPY . .

RUN go build -o main .

CMD [\"./main\"]" > $PROJECT_NAME/Dockerfile

# Criação do arquivo docker-compose.yml
echo "version: '3.8'
services:
  auth-service:
    build: ./cmd/auth-service
    ports:
      - \"8081:8081\"
    depends_on:
      - kafka
  loan-service:
    build: ./cmd/loan-service
    ports:
      - \"8082:8082\"
    depends_on:
      - kafka
  transaction-service:
    build: ./cmd/transaction-service
    ports:
      - \"8083:8083\"
    depends_on:
      - kafka
  kafka:
    image: wurstmeister/kafka:latest
    ports:
      - \"9093:9093\"
    depends_on:
      - zookeeper
  zookeeper:
    image: wurstmeister/zookeeper:latest
    ports:
      - \"2181:2181\"
" > $PROJECT_NAME/docker-compose.yml

# Criar o go.mod inicial
echo "module financial-app

go 1.20" > $PROJECT_NAME/go.mod

# Criar o go.sum
touch $PROJECT_NAME/go.sum

# Criar o arquivo README.md
echo "# Financial App\n\nEste é um aplicativo de microserviços em Go com Kafka para comunicação assíncrona." > $PROJECT_NAME/README.md

echo "Estrutura de projeto criada com sucesso!"
