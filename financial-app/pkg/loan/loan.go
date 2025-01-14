package loan

import (
	"errors"
	"fmt"
)

// CreateLoan creates a loan with the given amount and interest rate.
// It returns an error if the amount or rate are invalid (<= 0).
func CreateLoan(amount float64, rate float64) error {
	// Validate that the amount is greater than zero
	if amount <= 0 {
		return errors.New("loan amount must be greater than zero")
	}

	// Validate that the interest rate is greater than zero
	if rate <= 0 {
		return errors.New("interest rate must be greater than zero")
	}

	// If validation passes, print the loan details
	fmt.Printf("Loan created successfully! Amount: %.2f, Interest Rate: %.2f%%\n", amount, rate)
	return nil
}
