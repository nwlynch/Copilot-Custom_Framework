---
name: python-training-modules
description: Python training modules for QA testers covering basics, pytest fundamentals, type hints, and security basics for quality code production.
version: 1.0.0
author: Neville Lynch
license: MIT
platforms: [linux, macos, windows]
tags: [python, training, qa, basics, pytest, types, security, education]
metadata:
  hermes:
    tags: [python, training, qa, education]
    related_skills: [python-qa-guardrails, qa-checklist, codebase-inspection]
---

# Python Training Modules for QA Testers

## Overview

This collection of training modules teaches QA testers and novice Python programmers how to write quality code from zero to hero.

**Target Audience:**
- 🎓 QA testers automating tests
- 📝 Junior developers
- 🧪 Test automation engineers  
- 🔄 Manual testers adding automation
- 💼 Non-programmers in QA

**Prerequisites:** None — start from basics!

## Course Outline

### Module 1: Python Basics (2 hours)

**File:** `python_basics_for_qa.md`

**Time:** 2 hours

**Topics:**
- Python syntax and structure
- Variables, types, and operators
- Control flow (if/else, loops)
- Functions with docstrings
- Type hints for clarity

**Outcome:** Can write basic Python functions with documentation.

**Learning Objectives:**
- [ ] Write `def function_name(params):` functions
- [ ] Add type hints: `params: Type`
- [ ] Document with docstrings
- [ ] Use `list`, `dict`, `str`, `int`, `bool`
- [ ] Handle None and exceptions

**Exercises:**
1. Calculate total price from list
2. Validate email format
3. Fetch data from API
4. Parse JSON response

### Module 2: Testing Fundamentals (2 hours)

**File:** `pytest_fundamentals.md`

**Time:** 2 hours

**Topics:**
- pytest basics
- Writing test functions
- Assert statements
- Test data fixtures
- Parameterized tests

**Outcome:** Can write tests for Python code.

**Learning Objectives:**
- [ ] Write `def test_function():` tests
- [ ] Use `pytest` to run tests
- [ ] Create `pytest.fixture` for data
- [ ] Test edge cases (empty, invalid, null)
- [ ] Mock external dependencies

**Exercises:**
1. Test login with valid/invalid credentials
2. Test database queries
3. Test API responses
4. Test business logic

### Module 3: Type Hints for Beginners (1.5 hours)

**File:** `type_hints_for_beginners.md`

**Time:** 1.5 hours

**Topics:**
- What type hints are
- Common type annotations
- Optional and Union types
- Collection types (List, Dict)
- Type checking with mypy

**Outcome:** Can add type hints to code.

**Learning Objectives:**
- [ ] Add `-> int` return annotations
- [ ] Use `Optional[T]` for nullable values
- [ ] Use `List[T]` for homogeneous lists
- [ ] Use `Dict[K, V]` for typed dicts
- [ ] Run `mypy` to check types
- [ ] Fix type errors

**Exercises:**
1. Add type hints to existing code
2. Fix mypy errors
3. Test with Union types
4. Create stub files for external modules

### Module 4: Security Basics (2 hours)

**File:** `security_basics.md`

**Time:** 2 hours

**Topics:**
- Hardcoded secrets (passwords, API keys)
- SQL injection vulnerabilities
- External input validation
- Environment variables for secrets
- Password hashing

**Outcome:** Can write secure Python code.

**Learning Objectives:**
- [ ] Never hardcode credentials
- [ ] Use environment variables
- [ ] Parameterize SQL queries
- [ ] Validate external inputs
- [ ] Never use eval() with user input
- [ ] Hash passwords, don't store plain text

**Exercises:**
1. Refactor code to use environment variables
2. Parameterize SQL queries
3. Validate external inputs
4. Fix SQL injection vulnerabilities

### Module 5: Exception Handling (1.5 hours)

**File:** `exception_handling.md`

**Time:** 1.5 hours

**Topics:**
- Why never use bare `except:`
- Catching specific exceptions
- Logging errors properly
- Error message clarity
- Error recovery

**Outcome:** Can handle exceptions properly.

**Learning Objectives:**
- [ ] Catch specific exceptions
- [ ] Log errors with context
- [ ] Handle edge cases
- [ ] Return appropriate errors
- [ ] Never silently ignore errors

**Exercises:**
1. Replace bare except with specific handlers
2. Add error recovery
3. Log with appropriate context
4. Test error paths

### Module 6: Enterprise Patterns (3 hours)

**File:** `enterprise-python-patterns.md`

**Time:** 3 hours

**Topics:**
- Dependency injection
- Repository pattern
- Factory pattern
- Strategy pattern
- Observer pattern
- Command pattern

**Outcome:** Can write production-quality code.

**Learning Objectives:**
- [ ] Understand and use DI
- [ ] Separate concerns properly
- [ ] Write testable code
- [ ] Follow DRY principle
- [ ] Single responsibility principle

**Exercises:**
1. Refactor to dependency injection
2. Use repository pattern
3. Create factory for fixtures
4. Apply strategy pattern

## Quick Start

### Step 1: Assess Your Level

**Beginner (No Python?)**
- Start with Module 1
- Work through exercises
- Pass exercises before next module

**Intermediate (Some Python?)**
- Do Module 1 exercises
- Skip to Module 2
- Learn pytest, not syntax

**Advanced (Know Python?)**
- Start with Module 4 (security)
- Skip to Module 6 (patterns)
- Focus on best practices

### Step 2: Study Order

**Recommended:**
1. Module 1: Python Basics
2. Module 2: Testing Fundamentals
3. Module 3: Type Hints
4. Module 4: Security Basics
5. Module 5: Exception Handling
6. Module 6: Enterprise Patterns

**Skip Order for QA:**
1. Module 2: Testing First
2. Module 4: Security
3. Module 1: Python Basics
4. Module 3: Type Hints
5. Module 5: Exceptions
6. Module 6: Patterns

### Step 3: Run Exercises

```bash
# Check exercise solutions
cat exercises/solutions/module1_exercises.py

# Run exercise tests
pytest exercises/

# View expected output
pytest exercises/ --tb=short
```

### Step 4: Verify Learning

Before moving to next module, verify:

**Module 1: Python Basics:**
```python
# Can write function with docstring
def calculate_total(products: list) -> float:
    """
    Calculate total price for products.
    
    Args:
        products: List of product dicts with 'price'
    
    Returns:
        Total price as float
    """
    ...

# Can test it
def test_calculate_total():
    products = [{"price": 10.00}, {"price": 5.00}]
    assert calculate_total(products) == 15.00
```

**Module 2: Testing Fundamentals:**
```python
# Can write tests with fixtures
@pytest.fixture
def valid_form():
    return {"email": "test@example.com", "password": "secret"}

@pytest.fixture
def invalid_form():
    return {"email": "", "password": ""}

def test_login_success(valid_form):
    assert test_login(valid_form)

def test_login_fails_with_invalid(invalid_form):
    assert not test_login(invalid_form)
```

**Module 3: Type Hints:**
```python
# Can use typing module
from typing import Union, Optional, List

def parse_user_data(
    data: dict,
    include_details: bool = False,
) -> Union[dict, None]:
    """Parse user data, optionally with details."""
    if not data:
        return None
    return {k: v for k, v in data.items()}
```

**Module 4: Security:**
```python
# Can use environment variables
import os

def get_database_uri() -> str:
    return os.environ.get("DATABASE_URI", "")

def get_api_key() -> str:
    return os.environ.get("API_KEY")
```

**Module 5: Exceptions:**
```python
# Can handle specific exceptions
try:
    db.query(user_id)
except DatabaseConnectionError as e:
    logger.warning(f"DB unavailable: {e}")
except UserNotFoundError as e:
    logger.warning(f"User not found: {e}")
except Exception as e:
    logger.critical(f"Unexpected error: {e}")
    raise
```

**Module 6: Enterprise Patterns:**
```python
# Can write with DI
class UserRepository(Protocol):
    def find_by_id(self, user_id: str) -> Optional[User]:
        ...

def process_order(
    user_id: str,
    order_data: dict,
    repository: UserRepository = RealDatabaseRepository(),
) -> Order:
    ...
```

## Module Files

| Module | File | Topics | Time |
|--|--|--|--|
| Python Basics | `python_basics_for_qa.md` | Syntax, variables, control flow | 2h |
| Testing | `pytest_fundamentals.md` | pytest, fixtures, assertions | 2h |
| Type Hints | `type_hints_for_beginners.md` | typing module, mypy | 1.5h |
| Security | `security_basics.md` | Secrets, SQL injection, validation | 2h |
| Exceptions | `exception_handling.md` | Specific errors, logging | 1.5h |
| Enterprise | `enterprise-python-patterns.md` | DI, repository, factory | 3h |
| Testing Patterns | `testing-patterns.md` | Testing scenarios | 2h |
| API Testing | `api-testing-patterns.md` | Rest API tests | 1.5h |
| Database Testing | `database-testing.md` | DB queries, transactions | 2h |

## Exercise Files

Located in `exercises/`:

- `solutions/module1_exercises.py` — Basic functions
- `solutions/module2_testing.py` — Pytest basics
- `solutions/module3_types.py` — Type hints
- `solutions/module4_security.py` — Security patterns
- `solutions/module5_exceptions.py` — Error handling
- `solutions/module6_patterns.py` — Enterprise patterns

## Tests

```bash
# Run all tests
pytest exercises/

# Run specific module
pytest exercises/module1/

# Show progress
pytest exercises/ --tb=short -v

# Coverage
pytest exercises/ --cov=exercises/ --cov-report=term
```

## Certificate of Completion

Upon completing all modules, certificate issued:

**"Certificate of Python QA Excellence"**

This certifies that [Name] has completed the Python QA Training Program covering:

- Python Basics ✓
- Testing Fundamentals ✓  
- Type Hints ✓
- Security Basics ✓
- Exception Handling ✓
- Enterprise Patterns ✓

Total hours: 15

Issued: [Date]

Signed: QA Training Coordinator

## Assessment

**Passing grade:** 80% on exercises

**Grading:**
- Exercises: 40%
- Final project: 60%

**Projects:**
- Unit testing project
- Integration testing project
- Security hardening project
- Code review project

## Support

**Need help?**

- **GitHub Copilot**: Use AI for guidance
- **Type hints**: `typing` module docs
- **pytest**: Testing documentation
- **Security**: OWASP top 10
- **Code review**: Pull request guides

**Community:**
- Python QA Discord
- Testing Stack Overflow
- Security mailing list
- Code review forums

## License

MIT License
