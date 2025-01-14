package main

import (
	"fmt"
	"log"
	"strconv"

	"financial-app/pkg/loan"
)

func main() {
	// Example values for loan creation
	amount := 1000.0
	rate := "5.5" // Interest rate as string, which will be converted to float64

	// Convert the rate from string to float64
	convertedRate, err := strconv.ParseFloat(rate, 64)
	if err != nil {
		// Handle error if the conversion fails
		log.Fatalf("Error converting rate to float64: %v", err)
	}

	// Call the CreateLoan function with the converted rate
	err = loan.CreateLoan(amount, convertedRate)
	if err != nil {
		// Handle error if the loan creation fails
		log.Fatalf("Error creating loan: %v", err)
	}

	// Success message
	fmt.Println("Loan created successfully!")
}
