---
name: python-beginners-guide
description: Comprehensive Python training guide for QA testers and novice programmers, covering Python basics, testing fundamentals, type hints, and security basics for quality code production.
version: 1.0.0
author: Neville Lynch
license: MIT
platforms: [linux, macos, windows]
tags: [python, training, qa, beginners, testing, education, novices]
metadata:
  hermes:
    tags: [python, training, qa, beginners, novices]
---

# Python for QA Testers: Complete Training Guide

## Overview

This guide teaches **QA testers** and **novice Python programmers** how to write **quality, well-formatted code** that:

- ✅ Follows PEP 8 style guidelines
- ✅ Uses type hints for safety
- ✅ Has comprehensive tests
- ✅ Handles errors properly
- ✅ Avoids security mistakes
- ✅ Follows enterprise patterns

## Target Audience

**Who should use this:**

- 🎓 QA testers learning Python
- 📝 Junior developers
- 🧪 Test automation engineers
- 🔄 Manual testers automating tests
- 📚 Students learning Python with Python
- 💼 Non-programmers adding automation

**What if you don't know Python:**

Don't worry! This guide assumes **zero prior knowledge** and builds from basics.

## Course Structure

### Module 1: Python Basics (15 min)

Learn fundamental Python concepts.

#### 1.1 Python Syntax

```python
# GOOD - Clear, documented code
def test_login(form_data: dict) -> bool:
    """
    Test user login with provided form data.
    
    Args:
        form_data: Dictionary containing 'email' and 'password'
    
    Returns:
        True if login successful, False otherwise
    """
    email = form_data.get('email', '')
    password = form_data.get('password', '')
    
    # Validate required fields
    if not email or not password:
        return False
    
    return True

# BAD - Unclear, undocumented
def check(f):
    if f['e'] and f['p']:
        return True
    return False
```

**Key takeaways:**
- Use meaningful function names
- Document arguments with docstrings
- Return type hints
- Handle edge cases explicitly

#### 1.2 Python Types

Understanding types is crucial:

| Type | Example | Use Case |
|--|--|--|
| `int` | `42` | Integer values |
| `float` | `3.14` | Decimal numbers |
| `str` | `"hello"` | Text strings |
| `list` | `[1, 2, 3]` | Ordered collections |
| `dict` | `{"a": 1}` | Key-value mappings |
| `bool` | `True` | True/false flags |
| `None` | `None` | Explicitly no value |

```python
# Type conversion
text = "42"     # string
number = int(text)  # integer
formatted = f"{number:.2f}"  # f-string formatting
```

### Module 2: Testing Fundamentals (20 min)

Learn to write tests for Python code.

#### 2.1 Writing Tests with pytest

**Basic test structure:**

```python
# tests/test_login.py

import pytest

def test_login_with_valid_credentials():
    """Test successful login with valid credentials."""
    form_data = {
        "email": "user@example.com",
        "password": "correct_password"
    }
    
    assert test_login(form_data) is True

def test_login_with_invalid_email():
    """Test login fails with invalid email."""
    form_data = {
        "email": "not-an-email",  # Invalid!
        "password": "correct_password"
    }
    
    assert test_login(form_data) is False

def test_login_with_empty_fields():
    """Test login fails with empty fields."""
    form_data = {
        "email": "",
        "password": ""
    }
    
    assert test_login(form_data) is False

def test_login_without_required_fields():
    """Test login fails without email."""
    form_data = {
        "email": None,
        "password": "correct_password"
    }
    
    assert test_login(form_data) is False
```

**pytest conventions:**
- Functions starting with `test_` are tests
- Assertions check conditions
- Doctests in docstrings work too

#### 2.2 Running Tests

```bash
# Run all tests
pytest tests/

# Run specific test
pytest tests/test_login.py

# Run with verbose output
pytest tests/ -v

# Generate coverage report
pytest tests/ --cov=src/ --cov-report=html
```

#### 2.3 Test Data Management

Organize test data:

```python
# fixtures.py - Reusable test data

@pytest.fixture
def valid_form_data() -> dict:
    """Valid login form data."""
    return {
        "email": "user@example.com",
        "password": "correct_password",
    }

@pytest.fixture
def invalid_form_data() -> dict:
    """Invalid login form data."""
    return {
        "email": "",
        "password": "",
    }
```

Use fixtures across tests:

```python
# tests/test_login.py
import pytest
from myproject.fixtures import valid_form_data

def test_login_success(valid_form_data: dict):
    """Test successful login."""
    assert test_login(valid_form_data) is True
```

### Module 3: Type Hints for Beginners (15 min)

Learn to add type hints.

#### 3.1 Basic Type Hints

```python
# Before - No types, unclear signature
def calculate_total(products: list, quantity: int) -> int:
    ...

# After - Type hints add clarity
from typing import List, Dict, Optional

def calculate_total(
    products: List[Dict[str, float]],
    quantity: int = 1,
    currency: str = "USD",
) -> float:
    """
    Calculate total for products.
    
    Args:
        products: List of product dictionaries
        quantity: Number of units per product (default: 1)
        currency: Currency code (default: USD)
    
    Returns:
        Total price as float (always includes decimal point)
    """
    ...
```

#### 3.2 Common Type Patterns

```python
# Optional parameter
def get_user(id: int, include_details: bool = False) -> Optional[User]:
    """Optional second parameter."""
    return fetch_user(id)

# Union types
def parse_value(value: str) -> Union[int, float, str]:
    """Can return int, float, or str."""
    ...

# Class type hints
from dataclasses import dataclass

@dataclass
class Product:
    name: str
    price: float

def create_order(products: List[Product]) -> Order:
    """Order from product list."""
    ...
```

#### 3.3 Type Checking (mypy)

Install mypy for type checking:

```bash
pip install mypy
```

Run checks:

```bash
# Check entire project
mypy --ignore-missing-imports .

# Check specific file
mypy tests/test_file.py

# Strict checking
mypy --strict tests/
```

**Type hints prevent bugs:**
- Catch missing arguments
- Wrong argument types
- Return value mismatches
- Inconsistent API design

### Module 4: Security Basics (20 min)

Learning common security mistakes and how to avoid them.

#### 4.1 Hardcoded Secrets (DON'T DO THIS)

```python
# BAD - Password in code!
def connect_database():
    import psycopg2
    conn = psycopg2.connect(
        database="mydb",
        user="admin",
        password="secret123"  # ❌ Never do this!
    )
```

**Why it's bad:**
- Anyone viewing code sees password
- Git history retains passwords forever
- Password leaks to other developers
- Password exposed in backups
- Password visible in stack traces

**Good alternative:**

```python
# GOOD - Environment variables
import os

def connect_database():
    import psycopg2
    conn = psycopg2.connect(
        database=os.environ.get("DB_NAME", "default"),
        user=os.environ.get("DB_USER", "default"),
        password=os.environ.get("DB_PASSWORD"),
        host=os.environ.get("DB_HOST", "localhost"),
    )
```

#### 4.2 SQL Injection (NEVER DO THIS)

```python
# BAD - User input in query!
def get_user(user_id: str):
    cursor.execute(
        f"SELECT * FROM users WHERE id = '{user_id}'",
    )
```

**Why it's bad:**
- User can run SQL commands
- Database can be compromised
- Row of privilege escalation
- Data theft possible

**Good alternative:**

```python
# GOOD - Parameterized queries
def get_user(user_id: str):
    cursor.execute(
        "SELECT * FROM users WHERE id = %s",
        (user_id,),
    )
```

#### 4.3 Testing Database Access

```python
# tests/test_database_access.py

def test_get_user_returns_none_for_missing_id():
    """Test gracefully handles missing user."""
    result = get_user("none_@this._com")  # Invalid ID
    assert result is None

def test_get_user_with_integer_id():
    """Test accepts valid integer ID."""
    result = get_user("123")
    assert result is not None

@pytest.mark.parametrize(
    "id_value",
    ["123", "456", "1000"],
)
def test_get_user_with_various_ids(id_value: str):
    """Test multiple user IDs."""
    result = get_user(id_value)
    assert result is not None or result is None
```

### Module 5: Exception Handling (15 min)

Learn to handle exceptions properly.

#### 5.1 Never Use Bare Except

```python
# BAD - Silently ignores ALL errors
def fetch_user(user_id: str):
    try:
        # ...
    except:
        pass  # ❌ What happened?!

# BAD - Prints error to console (not production)
    except OSError:
        print("Database error")  # ❌ Don't print in production!

# GOOD - Log and handle appropriately
    except DatabaseConnectionError as e:
        logger.warning(f"Database unavailable: {e}")
        return None
    except ValueError as e:
        logger.error(f"Invalid user ID: {e}")
        return None
```

#### 5.2 Specific Exception Types

```python
# Common exception types:
class ValidationError(Exception):
    """Raised when input data is invalid."""
    pass

class DatabaseConnectionError(Exception):
    """Raised when database is unavailable."""
    pass

class InvalidUserError(Exception):
    """Raised for invalid user data."""
    pass

# Use specific exceptions
def test_user(user_data: dict):
    if not user_data.get("email"):
        raise ValidationError("Missing email")
    
    try:
        cursor.execute(
            "SELECT * FROM users WHERE email = %s",
            (user_data["email"],)
        )
    except psycopg2.OperationalError as e:
        raise DatabaseConnectionError(e)
```

### Module 6: Enterprise Patterns (25 min)

Learn common patterns for production code.

#### 6.1 Dependency Injection

Testable code structure:

```python
# GOOD - Depends on interfaces, not implementations
from typing import Protocol, runtime_checkable

@runtime_checkable
class DataFetcher(Protocol):
    def fetch_user(self, user_id: str) -> Optional[User]:
        ...

class MockDataFetcher(DataFetcher):
    """For testing."""
    def fetch_user(self, user_id: str) -> Optional[User]:
        return User(id=user_id, name="test")

class RealDataFetcher(DataFetcher):
    """Production data fetcher."""
    def fetch_user(self, user_id: str) -> Optional[User]:
        ...

def process_order(
    user_id: str,
    order_data: dict,
    data_fetcher: DataFetcher = MockDataFetcher(),
) -> Order:
    """Process order with dependency injection."""
    return ...
```

**Testing with DI:**

```python
# tests/test_order_processing.py

import pytest

@pytest.fixture
def order_processing_data_fetch(mock_data_fetcher: DataFetcher):
    """Setup for order processing tests."""
    return process_order(
        user_id="123",
        order_data={"item": "widget"},
        data_fetcher=mock_data_fetcher,
    )
```

#### 6.2 Repository Pattern

Separate data access from business logic:

```python
# src/repositories.py
from typing import Optional
from abc import ABC

class UserRepository(ABC):
    """Abstract base for user repositories."""
    
    def find_by_id(self, user_id: str) -> Optional[User]:
        ...
    
    def find_by_email(self, email: str) -> Optional[User]:
        ...

class MockUserRepository(UserRepository):
    """For testing."""
    def find_by_id(self, user_id: str) -> Optional[User]:
        return User(id=user_id, name=f"user{user_id}")

class PostgreSQLUserRepository(UserRepository):
    """Production repository."""
    def __init__(self, db_uri: str):
        self.db = psycopg2.connect(db_uri)
    
    def find_by_id(self, user_id: str) -> Optional[User]:
        ...
```

**Business logic uses repository:**

```python
# src/business_logic.py
from src.repositories import UserRepository

class UserBusinessLogic:
    """User business logic."""
    
    def __init__(self, user_repository: UserRepository):
        self.user_repository = user_repository
    
    def activate_user(self, user_id: str) -> bool:
        """Activate user account."""
        user = self.user_repository.find_by_id(user_id)
        if user is None:
            raise UserNotFoundError(user_id=user_id)
        
        update_user(user_id, status=active)
        return True
```

### Module 7: Code Review Checklist (10 min)

Review checklist before push.

#### 7.1 Checklist Structure

```markdown
# QA Tester Review Checklist

## Before Commit [ ]

- [ ] Code formatted (Black)
- [ ] Type hints present
- [ ] Test coverage >= 80%
- [ ] Security scan clean
- [ ] No hardcoded secrets

## Code Quality [ ]

- [ ] Docstrings present
- [ ] Error messages informative
- [ ] Logs appropriate level
- [ ] No commented-out code

## Edge Cases [ ]

- [ ] Empty inputs handled
- [ ] Invalid inputs handled
- [ ] Database connection lost handled
- [ ] Network timeout handled
```

#### 7.2 Automated Checklist

```bash
#!/bin/bash
# qa_reviewer_checklist.sh
# Run before push

set -e

echo "📋 QA Review Checklist"
echo ""

echo "Formatting check (Black)..."
black --check --diff . || true

echo ""
echo "Type hints check (mypy)..."
mypy --ignore-missing-imports . || true

echo ""
echo "Security check..."
python3 utilities/check-secrets.sh . || true

echo ""
echo "Coverage check..."
pytest --cov=src/ --cov-report=term-missing tests/

echo ""
echo "Style check (ruff)..."
ruff check . || true

echo ""
echo "✅ All checks complete"
```

## Quick Reference

| Task | Command | Purpose |
|--|--|--|
| Format code | `black src/` | Apply PEP 8 style |
| Type check | `mypy src/` | Verify type hints |
| Fix style | `black --fix src/` | Auto-format code |
| Test | `pytest tests/` | Run test suite |
| Coverage | `pytest --cov=src/` | Check coverage |
| Security | `check-secrets.sh` | Scan for secrets |
| Style check | `ruff check .` | Verify PEP 8 |
| Fix style | `ruff check --fix .` | Auto-fix style |
| Full check | `qa_reviewer_checklist.sh` | Run all checks |

## Next Steps

After this guide, you can:

1. **Automated testing**
   - Write automated tests
   - CI/CD pipeline integration
   - Code quality gates

2. **Code reviews**
   - Review peers' changes
   - Use security checklist
   - Enforce quality gates

3. **Senior-level work**
   - Code architectural patterns
   - Performance optimization
   - Scale testing

## Resources

### Practice Projects

- **GitHub Copilot**: Learn with AI
- **Pytest fixtures**: Test data management
- **Mypy tutorials**: Advanced typing
- **Security best practices**: Avoid common mistakes

### Reading Lists

- [`python_basics_for_qa.md`](./python_basics_for_qa.md)
- [`pytest_fundamentals.md`](./pytest_fundamentals.md)
- [`type_hints_for_beginners.md`](./type_hints_for_beginners.md)
- [`security_basics.md`](./security_basics.md)
- [`dependency_injection.md`](./dependency_injection.md)
- [`repository_pattern.md`](./repository_pattern.md)

## Support

Need help?

- **GitHub Copilot**: Use AI for guidance
- **Type hints**: `typing` module documentation
- **pytest**: Testing documentation
- **Security**: OWASP top 10

## License

MIT License
