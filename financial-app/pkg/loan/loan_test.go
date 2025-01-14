package loan

import (
	"testing"
)

// TestCreateLoan tests the CreateLoan function with various input values.
func TestCreateLoan(t *testing.T) {
	// Define test cases
	tests := []struct {
		amount  float64
		rate    float64
		wantErr bool
	}{
		// Valid case: positive amount and rate
		{1000.0, 5.5, false},
		// Invalid case: amount is zero
		{0.0, 5.5, true},
		// Invalid case: rate is zero
		{1000.0, 0.0, true},
		// Invalid case: negative amount
		{-1000.0, 5.5, true},
		// Invalid case: negative rate
		{1000.0, -5.5, true},
	}

	// Iterate through each test case
	for _, tt := range tests {
		// Run CreateLoan with the provided test data
		err := CreateLoan(tt.amount, tt.rate)

		// Check if the error matches the expected result
		if (err != nil) != tt.wantErr {
			t.Errorf("CreateLoan(%f, %f) error = %v, wantErr %v", tt.amount, tt.rate, err, tt.wantErr)
		}
	}
}
