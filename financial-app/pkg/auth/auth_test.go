package auth

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestGenerateJWT(t *testing.T) {
	token, err := GenerateJWT("user123")
	assert.NoError(t, err)
	assert.NotNil(t, token)
}

func TestParseJWT(t *testing.T) {
	token, err := GenerateJWT("user123")
	assert.NoError(t, err)

	claims, err := ParseJWT(token)
	assert.NoError(t, err)
	assert.Equal(t, "user123", claims["user_id"])
}
