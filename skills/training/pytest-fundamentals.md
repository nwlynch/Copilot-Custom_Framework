---
name: pytest-fundamentals
description: Learn pytest fundamentals for QA testers, covering test writing, fixtures, assertions, and test patterns for automation.
version: 1.0.0
author: Neville Lynch
license: MIT
platforms: [linux, macos, windows]
tags: [python, pytest, testing, qa, fixtures, assertions, automation, education]
metadata:
  hermes:
    tags: [pytest, testing, qa]
    related_skills: [python-qa-guardrails, qa-checklist, test-driven-development]
---

# Pytest Fundamentals for QA Testers

## Overview

This module teaches QA testers how to write tests with pytest:

**Prerequisites:**
- Python basics (Module 1)
- Basic English grammar

**Time:** 2 hours reading + exercises

**Outcome:** Can write tests with fixtures and assertions.

## Quick Start

```bash
# Install pytest
pip install pytest pytest-cov

# Run tests
pytest tests/

# View progress
pytest tests/ --tb=short -v

# Coverage
pytest tests/ --cov=src/ --cov-report=term
```

## Core Concepts

### Test Function Basics

```python
# Basic test
def test_calculate_total():
    """Test calculating total from product list."""
    products = [
        {"name": "apple", "price": 1.00},
        {"name": "banana", "price": 0.50},
    ]
    
    result = calculate_total(products)
    
    # Assert expected result
    assert result == 1.50
```

**pytest conventions:**
- Function starting with `test_` is a test
- Assertions use `assert` keyword
- Docstring explains test purpose
- Single behavior per test

### Test Descriptions

Write clear test names:

```python
# BAD - Unclear
def test_login():
    """Test login."""
    ...

# GOOD - Clear with docstring
def test_login_with_valid_credentials():
    """Test login with valid credentials succeeds.
    
    Expected behavior:
    - Returns success status
    - Session token created
    - Password not logged
    
    Raises:
        ValidationError: If credentials invalid
    """
    ...
```

### Assertions

**Common assertion patterns:**

```python
# Equal check
assert result == expected

# Not equal
assert result != "error"

# Truthy
assert result  # Same as assert result is not None and bool(result)

# In collection
assert user in users

# Contains
assert "user@example.com" in form_data

# True/False
assert isinstance(result, dict)
assert result.is_valid is True

# Length
assert len(data) > 0

# None check
assert data is None  # or data == None

# Exception
with pytest.raises(ValueError):
    bad_process(invalid_data)
```

### Fixtures

**Setup test data:**

```python
# fixtures.py - Shared test data

class ValidForm:
    """Valid login form. """
    email: str = "test@example.com"
    password: str = "correct"
    required = 2  # Fields required

class InvalidForm:
    """Invalid login form."""
    email: str = ""
    password: str = ""

# pytest fixture decorator
@pytest.fixture
def valid_form() -> ValidForm:
    """Valid login form data."""
    return ValidForm()

@pytest.fixture
def invalid_form() -> ValidForm:
    """Invalid login form data."""
    return InvalidForm()

@pytest.fixture
def product_list() -> list:
    """Sample product list."""
    return [
        {"name": "apple", "price": 1.00},
        {"name": "banana", "price": 0.50},
    ]
```

**Use fixtures in tests:**

```python
# tests/test_login.py
import pytest
from myproject.fixtures import valid_form, invalid_form

def test_login_success(valid_form):
    """Test successful login."""
    result = test_login(valid_form)
    assert result is not None

def test_login_fails(invalid_form):
    """Test login fails with invalid form."""
    result = test_login(invalid_form)
    assert result is None
```

### Parameterized Tests

**Same test, multiple cases:**

```python
# tests/test_products.py

@pytest.mark.parametrize(
    "product_data,expected_name",
    [
        ({"name": "apple"}, "apple"),
        ({"name": "banana"}, "banana"),
        pytest.param({"name": ""}, None, marks=pytest.mark.skip),
    ],
)
def test_product_name(product_data, expected_name):
    """Test product name extraction.
    
    Args:
        product_data: Product data dictionary
        expected_name: Expected name or None if invalid
    """
    result = get_product_name(product_data)
    assert result == expected_name
```

**Benefits:**
- Runs test multiple times
- Tests different cases
- Clear test purpose
- Reuse test logic

### Mocking

**Mock external dependencies:**

```python
# tests/test_database.py
import pytest
from unittest.mock import Mock, patch

@pytest.fixture
def mock_repository():
    """Mock user repository."""
    mock = Mock()
    mock.find_by_id.return_value = User(id=123, name="alice")
    return mock

def test_get_user(mock_repository):
    """Test fetching user from repository."""
    with patch("src.repository.UserRepository.find_by_id", mock_repository.find_by_id):
        result = get_user(123)
    
    # Verify repository called
    mock_repository.find_by_id.assert_called_once_with(123)
    
    # Verify return value
    assert result is not None

@pytest.fixture
def mock_database():
    """Mock database connection."""
    mock = Mock()
    mock.cursor.return_value.fetchone.return_value = (123, "alice", "active")
    return mock

def test_query(mock_database):
    """Test database query."""
    # ...
```

**Common mocking patterns:**
- `@patch()` decorator
- `with patch() context manager`
- `Mock` objects
- `MagicMock` for auto-mocking

### Test Organization

**Organize tests logically:**

```python
# tests/test_products.py

import pytest
from myproject import get_product_name

class TestProductValidation:
    """Product validation tests."""
    
    @pytest.mark.parametrize("product", [
        {"name": "apple", "price": 1.00},
        {"name": "banana", "price": 0.50},
    ])
    def test_valid_product(self, product):
        """Test valid product data."""
        result = get_product_name(product)
        assert result is not None
    
    def test_empty_name(self):
        """Test product with empty name fails."""
        with pytest.raises(ValidationError):
            get_product_name({"name": "", "price": 1.00})
    
    def test_missing_name(self):
        """Test product without name field fails."""
        with pytest.raises(ValidationError):
            get_product_name({"price": 1.00})

class TestPricing:
    """Pricing tests."""
    
    def test_discount_applied(self):
        """Test discount is applied correctly."""
        product = {"name": "apple", "price": 1.00}
        result = apply_discount(product, 0.1)
        assert result == 0.90
```

**Test naming:**
- `TestClass` groups related tests
- `test_method_name` describes behavior
- `@pytest.mark.parametrize` for multiple cases

### Test Data Management

**External test data:**

```python
# tests/data/test_cases.yaml
- name: valid_user
  email: "test@example.com"
  password: "password123"
  expected: true

- name: invalid_email
  email: "not-an-email"
  password: "password123"
  expected: false
```

**Load test data:**

```python
import yaml

@pytest.fixture
def test_cases():
    """Load YAML test cases."""
    with open("tests/data/test_cases.yaml") as f:
        return yaml.safe_load(f)

def test_all_cases(test_cases):
    """Run all test cases."""
    for case in test_cases:
        result = login(case["email"], case["password"])
        assert result is True or result is False
```

### Test Coverage

**Measure code coverage:**

```bash
# Run tests with coverage
pytest tests/ --cov=src/ --cov-report=term-missing

# Generate HTML coverage report
pytest tests/ --cov=src/ --cov-report=html:coverage.html

# Open HTML report
open coverage.html
```

**Coverage targets:**
- Critical paths: >= 90%
- General code: >= 80%
- Edge cases: All must be covered

**Coverage report example:**
```
Name                          Stmts   Miss  Cover
--------------------------------------------------
src/business_logic.py             42      5    88%
src/database.py                   56      8    86%
src/api_client.py                 32      3    91%
--------------------------------------------------
Total                             130     16    88%
```

### Test Assertions Summary

**Common assertion patterns:**

| Pattern | Example | Meaning |
|--|--|--|
| `assert x == y` | `assert result == 10` | Equal to expected |
| `assert x is not None` | `assert result is not None` | Not none |
| `assert y in x` | `"item" in items` | In collection |
| `assert x > 0` | `assert len(data) > 0` | Greater than |
| `assert isinstance(x, T)` | `assert isinstance(result, dict)` | Type check |
| `assert x is True` | `assert result.is_valid is True` | Boolean value |
| `assert len(x) == y` | `assert len(data) == 10` | Collection length |
| `assert x is None` | `assert result is None` | None value |
| `with pytest.raises(ValueError):` | `assert` | Expect exception |

### Test Organization Best Practices

**1. Group related tests:**
- `tests/test_products.py` - Product logic
- `tests/test_prices.py` - Pricing logic
- `tests/test_user_management.py` - User CRUD

**2. Separate happy path from edge cases:**
- Test expected behavior first
- Then invalid inputs
- Then error cases

**3. One test, one behavior:**
- Don't test multiple things
- Keep tests focused
- Easy to read and understand

**4. Clear test names:**
- `test_login_with_valid_credentials()`
- `test_login_fails_with_invalid_email()`
- `test_query_returns_user_by_id()`

**5. Docstrings for tests:**
```python
def test_edge_case_large_list():
    """
    Test that query works with 1000 items.
    
    Performance should be maintained.
    """
```

## Exercises

### Exercise 1: Basic Tests

Write tests for:

```python
# tests/test_calculator.py
def test_add_positive_numbers():
    """Test adding two positive numbers."""
    assert add(2, 3) == 5

def test_add_negative_numbers():
    """Test adding two negative numbers."""
    assert add(-2, -3) == -5

def test_add_mixed_sign_numbers():
    """Test adding positive and negative numbers."""
    assert add(5, -3) == 2

def test_multiply_numbers():
    """Test multiplying numbers."""
    assert multiply(4, 5) == 20
```

Run tests:
```bash
pytest tests/test_calculator.py
```

### Exercise 2: Fixtures

Create fixtures for login tests:

```python
# fixtures.py
@pytest.fixture
def valid_form():
    """Valid login form."""
    return {
        "email": "test@example.com",
        "password": "correct_password",
    }

@pytest.fixture
def invalid_email_form():
    """Form with invalid email."""
    return {
        "email": "not-an-email",
        "password": "correct_password",
    }
```

Use in tests:
```python
# tests/test_login.py
def test_login_success(valid_form):
    """Test login with valid form."""
    assert test_login(valid_form)

def test_login_fails(invalid_email_form):
    """Test login fails with invalid email."""
    assert not test_login(invalid_email_form)
```

### Exercise 3: Parameterized Tests

Write parameterized tests:

```python
# tests/test_api.py
@pytest.mark.parametrize(
    "endpoint,expected_status",
    [
        ("/api/users", 200),
        ("/api/products", 200),
        ("/api/invalid", 404),
    ],
)
def test_api_endpoints(endpoint, expected_status):
    """Test API endpoints return expected status."""
    response = requests.get(endpoint)
    assert response.status_code == expected_status
```

Run tests:
```bash
pytest tests/test_api.py -v
```

### Exercise 4: Test Coverage

Add tests to improve coverage:

```python
# src/business_logic.py
def calculate_discount(price: float, discount_percent: float) -> float:
    """Calculate discounted price."""
    return price - (price * discount_percent)

# Add tests:
def test_discount_zero():
    """Test no discount."""
    assert calculate_discount(100, 0) == 100

def test_discount_100():
    """Test 100% discount."""
    assert calculate_discount(100, 100) == 0

def test_discount_negative():
    """Test negative discount raises."""
    with pytest.raises(ValueError):
        calculate_discount(100, -10)
```

Run coverage:
```bash
pytest --cov=src --cov-report=term
```

## Testing Tips

**1. Write tests before code (TDD):**
- See failing test
- Write minimal code
- Test passes

**2. Run tests often:**
```bash
# Run all tests
pytest tests/

# Run specific test
pytest tests/test_file.py::test_something

# Run with verbose output
pytest tests/ -v
```

**3. Test edge cases:**
- Empty inputs
- Invalid inputs
- Boundary values
- Null/None values
- Large data sets

**4. Don't test implementation:**
- Test behavior, not internal code
- Tests should document what code does

**5. Use mocks for external stuff:**
- Mock APIs
- Mock databases
- Mock file systems
- Mock network calls

**6. Keep tests fast:**
- Use mocks when possible
- Use fixtures for setup
- Don't include too much logic

**7. Test data management:**
- Separate fixtures from logic
- Reuse fixtures
- Keep setup minimal

## Summary

This module covers:

- ✅ Writing test functions
- ✅ Assert statements
- ✅ Fixtures for test data
- ✅ Parameterized tests
- ✅ Mocking external dependencies
- ✅ Test organization
- ✅ Test coverage

**Next steps:**
1. Module 3: Type hints
2. Module 4: Security
3. Module 5: Exception handling
4. Module 6: Enterprise patterns

**Resources:**
- pytest documentation: https://docs.pytest.org/
- pytest-cov documentation: https://pytest-cov.readthedocs.io/
- Testing Patterns: Testing Anti-Patterns
