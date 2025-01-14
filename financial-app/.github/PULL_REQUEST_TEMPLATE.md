## Description
**What changes were made?**
- Fixed logic in `loan-service` to correctly handle loan creation.
- Updated the `loan.go` file in the `pkg/loan` to ensure the rate is passed as a float.
- Refactored tests to ensure correct coverage for the loan creation functionality.

**Why were these changes necessary?**
- Ensures the `loan-service` and `loan.go` are working with correct data types (rate as float).
- The tests were failing previously due to type mismatches, which is now resolved.

## Type of change
- [ ] Bug fix
- [ ] New feature
- [ ] Refactor
- [ ] Documentation update

## How to test
- Run `go test ./...` to ensure all tests pass.
- Manually test the loan creation functionality in the service to verify the expected behavior.

## Checklist
- [ ] I have performed a self-review of my code.
- [ ] I have updated the documentation (if necessary).
- [ ] I have added tests that prove my fix is effective or that my feature works.
- [ ] I have reviewed the code and it follows the project's coding standards.

## Related issues
- Fixes # (issue number)
