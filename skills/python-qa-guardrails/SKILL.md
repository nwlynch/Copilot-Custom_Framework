---
name: python-qa-guardrails
description: Comprehensive guardrails for novice Python programmers and QA testers to produce quality, well-formatted code aligning with PEP 8, type safety, and enterprise standards. Enforces code quality verification, best practices, pre-commit gates, and enterprise Python patterns before code submission.
version: 1.0.0
author: Neville Lynch
license: MIT
platforms: [linux, macos, windows]
tags: [python, qa, testing, pep8, quality-gates, novices, education, code-review, types, enterprise-patterns]
metadata:
  hermes:
    tags: [python, qa, testing, pep8, quality-gates, novices, education, code-review]
    related_skills: [test-driven-development, requesting-code-review, github-pr-workflow, systematic-debugging]
---

# Python QA Guardrails for Novice Programmers

## Overview

This skill provides a **comprehensive guardrail system** for novice Python programmers, especially QA testers, to ensure they produce **quality, well-formatted code** that:

- ✅ Follows **PEP 8** style guidelines
- ✅ Uses **type hints** for all functions
- ✅ Maintains **comprehensive docstrings**
- ✅ Covers **all edge cases** with tests
- ✅ Handles **exceptions properly**
- ✅ Avoids **security vulnerabilities**
- ✅ Follows **enterprise design patterns**
- ✅ Has **high test coverage**

## What Makes This Skill Essential for QA Testers

QA testers who write Python code often need to:

1. **Validate test data** with proper type checking
2. **Handle edge cases** systematically (not just happy paths)
3. **Write clear assertions** that document behavior
4. **Understand code quality** standards before pushing
5. **Self-review** code before review
6. **Avoid common mistakes** like:
   - Silently ignoring exceptions
   - Hardcoding credentials
   - Missing input validation
   - Poor error messages

This skill provides the guardrails to prevent these mistakes.

## Core Principles

### 1. Write Tests First (TDD)

Never write implementation before the test. See `test-driven-development` skill.

### 2. Type Hints Everything

"All code without types is a lie." — Python Core Team
- Use `typing` module for all function signatures
- Type hints prevent runtime errors
- Tests catch type mismatches early

### 3. Validate All Inputs

"Trust but verify." — Unix Philosophy
- Test data must be validated before use
- Check for missing fields
- Validate format (email, phone, etc.)
- Raise appropriate exceptions on failure

### 4. Handle Exceptions Explicitly

Never use bare `except:` blocks:
```python
# BAD - Silently ignores all errors
try:
    validate_test_data(data)
except:
    pass  # ❌ What happened?

# GOOD - Specific exception
try:
    validate_test_data(data)
except ValidationError as e:
    logger.warning(f"Validation failed: {e}")
except ConnectionRefusedException as e:
    logger.error(f"Connection issue: {e}")
except Exception as e:  # Catch-all last
    logger.critical(f"Unexpected error: {e}")
    raise  # Don't silently continue
```

### 5. Security First

Never hardcode secrets:
- No passwords in source code
- No API keys in configs
- Use environment variables or secret managers
- Validate all external input

### 6. Document Everything

- Docstrings for all public functions and classes
- Inline comments for non-obvious logic
- Exception documentation
- Example usage in docstrings

## Pre-Commit Pipeline

Before pushing code, run these checks:

```bash
# 1. Format with Black
black -l 88 .

# 2. Type check
mypy --ignore-missing-imports .

# 3. Style check (PEP 8)
ruff check .

# 4. Security scan
python3 utilities/check-secrets.sh .

# 5. Test coverage
pytest --cov=src/ --cov-report=term-missing
```

If any check fails, fix the issue before committing.

## Best Practices Catalog

Located in `skills/best-practices/`:

### Testing Patterns

| Pattern | File | Description |
|--|--|--|
| Test Data Validation | `validation_patterns.md` | Test input data validation |
| Exception Handling | `exceptions-guide.md` | Proper exception handling |
| Database Queries | `database-testing.md` | Safe database query patterns |
| API Testing | `api-testing-patterns.md` | REST API test patterns |
| Edge Cases | `edge-case-guide.md` | Systematically testing edge cases |

### Enterprise Patterns

Located in `skills/enterprise-python/`:

| Pattern | File | Purpose |
|--|--|--|
| Dependency Injection | `dependency-injection.md` | Testable code structure |
| Repository Pattern | `repository-pattern.md` | Separate data access logic |
| Factory Pattern | `factory-pattern.md` | Test fixture creation |
| Strategy Pattern | `strategy-pattern.md` | Test scenario strategies |
| Observer Pattern | `observer-pattern.md` | Test notification system |
| Command Pattern | `command-pattern.md` | Test execution commands |

## QA Tester Checklist

Before submitting code for review, verify:

### Mandatory (Automated)

- [ ] PEP 8 compliant (Black + ruff)
- [ ] Type hints present on all functions
- [ ] No hardcoded secrets or credentials
- [ ] Docstrings document behavior
- [ ] Input validation present
- [ ] Exceptions handled explicitly

### QA-Specific

- [ ] Test data validation tested
- [ ] Edge cases covered in tests
- [ ] Error messages informative
- [ ] Code coverage >= 80% for critical paths
- [ ] Test suite runs cleanly
- [ ] No regressions introduced

See `skills/code-review/qa_tester_checklist.md` for full checklist.

## Quick Start Guide

### Day 1: Basics

1. Read `training/python_basics_for_qa.md`
2. Understand `pytest_fundamentals.md`
3. Type hints: `training/type_hints_for_beginners.md`
4. Exceptions: `training/exception_handling.md`

### Day 2: Validation

1. Input validation: `validation_patterns.md`
2. Type hints for validation
3. Test data schema design
4. Error handling patterns

### Day 3: Patterns

1. Dependency injection: `skills/enterprise-python/dependency-injection.md`
2. Repository pattern: `skills/enterprise-python/repository-pattern.md`
3. Factory for fixtures: `skills/enterprise-python/factory-pattern.md`

### Day 4: Testing

1. Edge case strategies: `edge-case-guide.md`
2. Coverage thresholds: `pytest --cov=`
3. Mocking vs real code
4. Async test patterns

### Day 5: Security

1. Never hardcode secrets
2. Environment variables
3. Secret scanning
4. Secure API design

## Example Code: Before and After

### BAD Example (Novice Code)

```python
def test_login(form_data):
    # BAD: No type hints
    # BAD: No validation
    # BAD: Silent error handling
    user = db.query("SELECT * FROM users WHERE email = '" + form_data.email + "'")
    if user.password == form_data.password:
        return True
    return False

# BAD: Returns string or boolean, no types
# BAD: SQL injection vulnerability
# BAD: No docstring explaining behavior
```

### GOOD Example (Guardrailed Code)

```python
from typing import Optional
from dataclasses import dataclass
from enum import Enum
import re

class LoginResult(Enum):
    SUCCESS = 1
    USER_NOT_FOUND = 2
    PASSWORD_INVALID = 3
    ACCOUNT_LOCKED = 4

@dataclass
class LoginForm:
    email: str
    password: str

def test_login(form_data: LoginForm) -> LoginResult:
    """Test user login credentials.
    
    Validates form data, queries database safely, and returns
    login result with appropriate error codes.
    
    Args:
        form_data: Login form with email and password
    
    Returns:
        LoginResult enum value indicating test outcome
    
    Raises:
        ValidationError: If form_data fields are invalid
        ConnectionRefusedException: If database unavailable
    """
    # VALIDATE EMAIL FORMAT
    if not is_valid_email(form_data.email):
        raise ValidationError(f"Invalid email format: {form_data.email}")
    
    # VALIDATE PASSWORD REQUIREMENTS
    if len(form_data.password) < 8:
        raise ValidationError("Password must be at least 8 characters")
    
    # SAFE DATABASE QUERY (parameterized)
    cursor.execute(
        "SELECT id, email, password_hash, status FROM users WHERE email = %s",
        (form_data.email,)
    )
    row = cursor.fetchone()
    
    if row is None:
        return LoginResult.USER_NOT_FOUND
    
    # COMPARE PASSWORDS (hashed)
    if not bcrypt.compare(form_data.password, row.password_hash):
        return LoginResult.PASSWORD_INVALID
    
    if row.status == 'locked':
        return LoginResult.ACCOUNT_LOCKED
    
    return LoginResult.SUCCESS

def is_valid_email(email: str) -> bool:
    """Check if email matches RFC 5322 format.
    
    Args:
        email: Email address string
    
    Returns:
        True if email format is valid
    """
    pattern = r'^[^@]+@[^@]+\.[^@]+$'
    return bool(re.match(pattern, email))
```

**Key Guardrails Applied:**

1. ✅ Type hints on all parameters and return values
2. ✅ Docstring with arguments, return, and exceptions
3. ✅ Input validation before database query
4. ✅ Parameterized SQL query (no injection)
5. ✅ Exception types: `ValidationError`
6. ✅ Enum for return values (not boolean)
7. ✅ Clear function name matching purpose

## Integration with Hermes Agent

Use these skills together for quality code:

### Pre-Commit Workflow

```python
delegate_task(
    goal="Implement feature with quality assurance guardrails",
    context="""
    Follow these steps:
    1. Write failing test first (TDD)
    2. Run pre-commit pipeline:
       - Format: black .
       - Type check: mypy --ignore-missing-imports .
       - Style: ruff check .
       - Secrets: check-secrets.sh
       - Tests: pytest tests/
    
    3. Document thoroughly with docstrings
    4. Handle all exceptions explicitly
    5. Validate all inputs
    6. Check code coverage >= 80%
    
    Review against:
    - qa_tester_checklist.md
    - security_review_checklist.md
    - testing_patterns.md
    
    If any automated check fails, fix before committing.
    """,
    toolsets=['terminal', 'file']
)
```

### Code Review

```python
delegate_task(
    goal="Review code quality guardrails compliance",
    context="""
    Review the submitted code against:
    1. PEP 8 compliance (Black + ruff)
    2. Type hints present everywhere
    3. Docstrings complete with examples
    4. Input validation present
    5. Exceptions handled specifically
    6. Security: no hardcoded secrets
    7. Test coverage threshold met
    8. Best practices from testing_patterns.md
    
    Return ONLY:
    - passed: boolean
    - issues: list of found issues
    - suggestions: list of improvements (non-blocking)
    
    Fail if security issues or missing tests found.
    Suggestions are informational only.
    """
)
```

## Code Quality Tools

Located in `skills/utilities/`:

| Tool | Purpose | Command |
|--|--|--|
| **format-python.sh** | Apply Black formatting | `black -l 88 .` |
| **check-types.sh** | Run mypy type checker | `mypy --ignore-missing-imports .` |
| **check-secrets.sh** | Scan for hardcoded secrets | `check-secrets.sh` |
| **test-single.sh** | Test single file/module | `pytest tests/file.py` |
| **check-coverage.sh** | Report test coverage | `pytest --cov=src/ --cov-report=term-missing` |

## Utility Scripts

### format-python.sh

Formats entire directory with Black:

```bash
#!/bin/bash
black -l 88 src/ tests/
echo "Formatted with Black 23.x"
```

### check-secrets.sh

Scans for common secrets patterns:

```bash
#!/bin/bash
# Check for hardcoded secrets
grep -riE "(password|secret|api_key|token)\s*=\s*['\"][^'\"]{6,}" src/
if [ $? -ne 0 ]; then
    echo "No hardcoded secrets found"
    exit 0
fi
echo "WARNING: Potential secrets found in source code"
exit 1
```

### check-coverage.sh

Reports code coverage:

```bash
pytest tests/ --cov=src/ --cov-report=term-missing
```

## Learning Resources

### Essential Reading (in order)

1. `training/python_basics_for_qa.md` — Python basics
2. `training/pytest_fundamentals.md` — Test writing
3. `training/type_hints_for_beginners.md` — Python typing
4. `validation_patterns.md` — Input validation
5. `exceptions-guide.md` — Error handling
6. `testing_patterns.md` — Common testing scenarios

### Advanced Patterns

1. `skills/enterprise-python/dependency-injection.md`
2. `skills/enterprise-python/repository-pattern.md`
3. `skills/enterprise-python/factory-pattern.md`
4. `skills/enterprise-python/strategy-pattern.md`

### Best Practices

1. `testing_patterns.md` — Testing patterns
2. `exceptions-guide.md` — Exception handling
3. `edge-case-guide.md` — Edge case strategies
4. `api-testing-patterns.md` — API test patterns

## Common Mistakes to Avoid

### Silent Error Handling

```python
# BAD - Silently ignores all errors
try:
    process_user_data(data)
except:
    pass  # ❌ What happened?

# GOOD — Log then raise
try:
    process_user_data(data)
except ValidationError as e:
    logger.warning(f"Validation failed: {e}")
    return None  # Graceful failure
except Exception as e:  # Catch-all last
    logger.critical(f"Unexpected error: {type(e).__name__}: {e}")
    raise  # Don't silently continue
```

### Missing Type Hints

```python
# BAD
def process_data(data):
    return data

# GOOD
def process_data(data: dict) -> dict:
    """Process user data and return cleaned version.
    
    Args:
        data: Raw user data dict
    
    Returns:
        Processed data dict with validated fields
    
    Raises:
        ValidationError: If data is missing required fields
        KeyErrors: If required keys missing
    """
    if "name" not in data:
        raise ValidationError("Missing required field: name")
    return data
```

### Hardcoded Credentials

```python
# BAD
def connect_database():
    conn = psycopg2.connect(
        host="localhost",
        port=5432,
        dbname="testdb",
        user="testuser",  # ❌ Hardcoded!
        password="secret123"  # ❌ Hardcoded!
    )

# GOOD — Use environment variables
def connect_database():
    import os
    conn = psycopg2.connect(
        host=os.environ.get("DB_HOST", "localhost"),
        port=os.environ.get("DB_PORT", "5432"),
        dbname=os.environ.get("DB_NAME"),
        user=os.environ.get("DB_USER"),
        password=os.environ.get("DB_PASSWORD")
    )
```

## Security Checklist

Before committing, verify:

- [ ] No hardcoded passwords or API keys
- [ ] No secrets in git history (use `.gitfilter` to exclude)
- [ ] All external inputs validated
- [ ] SQL queries use parameterization
- [ ] No eval() with user input
- [ ] No pickle/unpickle with unknown data
- [ ] HTTP headers set securely
- [ ] API endpoints use HTTPS
- [ ] Session handling secure

## Test Coverage Requirements

For enterprise-level code quality:

| Code Path | Coverage Requirement |
|--|--|--|
| Public functions | 80% minimum |
| Private methods | 50% minimum |
| Critical business logic | 90% minimum |
| Error handling paths | 100% covered |
| Edge cases | Must be tested explicitly |

## License

MIT License

```
