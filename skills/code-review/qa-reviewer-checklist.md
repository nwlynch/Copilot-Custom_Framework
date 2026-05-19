---
name: qa-checklist
description: Comprehensive QA tester review checklist covering code quality, security, testing, and style verification before code submission.
version: 1.0.0
author: Neville Lynch
license: MIT
platforms: [linux, macos, windows]
tags: [qa, checklist, review, quality-assurance, verification, testing, security, pep8]
metadata:
  hermes:
    tags: [qa, checklist, review, quality]
    related_skills: [python-quality-checking, python-qa-guardrails, test-driven-development, requesting-code-review]
---

# QA Tester Code Review Checklist

## Overview

This checklist helps QA testers ensure code quality before review. Use this as:

- 📝 **Pre-commit checklist**: Run before git commit
- 🧪 **Code review checklist**: For peer review
- 🎯 **Self-review checklist**: Own code verification
- ✅ **CI/CD quality gates**: Automated checks

## Quick Use

```bash
# Automated checks
./qa_reviewer_checklist.sh

# Manual review (print checklist)
less qa_reviewer_checklist.md
```

## Quick Checklist (10 min)

Check these items before push:

### Automated Checks [ ]

- [ ] `black --check` — PEP 8 formatting
- [ ] `ruff check .` — Style linting  
- [ ] `mypy src/` — Type hints check
- [ ] `check-secrets.sh` — No hardcoded credentials
- [ ] `pytest tests/` — All tests pass
- [ ] `pytest --cov=src/` — Coverage >= 80%

### Code Quality [ ]

- [ ] Docstrings present on all public functions
- [ ] Example in docstring
- [ ] Exception types documented
- [ ] No commented-out code
- [ ] No print() statements
- [ ] No magic numbers (use constants)

### Security [ ]

- [ ] No hardcoded passwords
- [ ] No hardcoded API keys
- [ ] No private SSH keys
- [ ] Database connections parameterized
- [ ] External inputs validated
- [ ] No eval() with user input

### Edge Cases [ ]

- [ ] Empty inputs handled
- [ ] Invalid inputs handled
- [ ] Database connection lost
- [ ] Network timeout handled
- [ ] File not found
- [ ] Permission denied

### Logging [ ]

- [ ] Errors logged, not printed
- [ ] Logs have context (timestamp, level)
- [ ] Sensitive data not logged
- [ ] Appropriate log level (not DEBUG in prod)

## Full Checklist (30 min)

### 1. Code Formatting [ ]

- [ ] Imports grouped alphabetically
- [ ] Imports from same package together
- [ ] No unnecessary blank lines
- [ ] Lines <= 88 characters
- [ ] Function definitions on own lines
- [ ] No continuation indentation issues

**Command:** `black --check --diff .`

### 2. Type Hints [ ]

- [ ] All parameters typed
- [ ] Return type specified
- [ ] `Optional[]` for nullable values
- [ ] `Union[X, Y]` for multiple types
- [ ] `List[]` for collections
- [ ] `Dict[K, V]` for dictionaries

**Command:** `mypy src/`

### 3. Exception Handling [ ]

- [ ] No bare `except:` blocks
- [ ] Specific exception types caught
- [ ] Exception re-raised appropriately
- [ ] No silent failures
- [ ] Error messages informative
- [ ] Sensitive info not in exception

**Example:**
```python
try:
    db.query(user_id)
except UserNotFoundError as e:
    logger.info(f"User not found: {e}")
except DatabaseConnectionError as e:
    logger.warning(f"Database unavailable: {e}")
except Exception as e:
    logger.critical(f"Unexpected error: {e}")
    raise
```

### 4. Input Validation [ ]

- [ ] Required fields validated
- [ ] Type of inputs validated
- [ ] Range of numeric values checked
- [ ] Format of strings checked (email, phone)
- [ ] Null values handled

**Example:**
```python
def process_user(data: dict) -> User:
    email = data.get("email")
    if not email or not is_valid_email(email):
        raise ValidationError("Invalid email")
    
    return User(email=email)
```

### 5. Logging [ ]

- [ ] Module-level constants for log levels
- [ ] Context in log messages (not "something failed")
- [ ] Sensitive data not logged:
  ```python
  # BAD
  logger.debug(f"User {user.email}: {user.password}")  # Never!
  
  # GOOD
  logger.debug(f"User {user.email[:8]}...")  # Mask
  ```
- [ ] Logging levels appropriate (INFO/WARNING, not ERROR)

### 6. Documentation [ ]

**Docstrings (PEP 257):**
```python
def process_user(data: dict) -> User:
    """Process user data and return user object.
    
    Args:
        data: User data dict with 'email' and 'name' fields
    
    Returns:
        Processed User object
    
    Raises:
        ValidationError: If data is missing required fields
        DatabaseConnectionError: If database unavailable
    
    Examples:
        >>> process_user({"email": "user@example.com", "name": "Alice"})
        User(email="user@example.com", name="Alice")
    """
```

### 7. Code Smell Detection [ ]

**DRY Principle (Don't Repeat Yourself):**
- [ ] No duplicate code blocks
- [ ] Helper functions for repeated logic
- [ ] Constants in `__init__.py` for magic numbers

**Single Responsibility:**
- [ ] Function does one thing
- [ ] Too long? Split into smaller functions
- [ ] Too many inputs? Consider options/dataclass

**Deep Nesting:**
- [ ] No deeply nested code
- [ ] Use guard clauses
- [ ] Refactor for clarity

### 8. Performance [ ]

- [ ] No unnecessary loops (especially on large data)
- [ ] Database closes properly
- [ ] File handles closed in finally
- [ ] Efficient data structures (dict vs list)
- [ ] String concatenation in loop? Use join()

### 9. Security [ ]

- [ ] No hardcoded credentials
- [ ] SQL queries parameterized
- [ ] External inputs validated
- [ ] Passwords stored hashed (not plain text)
- [ ] File permissions restrictive
- [ ] No eval/exec with user input
- [ ] API keys in environment variables

**SQL Injection Example:**
```python
# BAD
cursor.execute(
    f"SELECT * FROM users WHERE email = '{email}'",
)

# GOOD
cursor.execute(
    "SELECT * FROM users WHERE email = %s",
    (email,),
)
```

### 10. Test Coverage [ ]

```bash
pytest --cov=src/ --cov-report=term-missing tests/
```

**Target coverage:**
- Critical code paths: >= 90%
- General code: >= 80%
- Edge cases: Must be tested
- Error handling: Tested separately

**Test examples:**
```python
def test_process_user_valid():
    """Test with valid user data."""
    result = process_user({"email": "test@example.com"})
    assert result is not None

def test_process_user_missing_email():
    """Test missing email raises error."""
    with pytest.raises(ValidationError):
        process_user({"name": "test"})

def test_process_user_invalid_email_format():
    """Test invalid email format."""
    with pytest.raises(ValidationError):
        process_user({"email": "not-an-email"})
```

### 11. CI/CD Integration [ ]

**Example `.github/workflows/python.yml`:**
```yaml
name: QA Quality Gates

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      
      - name: Install dependencies
        run: pip install -r requirements.txt
      
      - name: Format check (Black)
        run: black --check --diff .
      
      - name: Type check (mypy)
        run: mypy --ignore-missing-imports .
      
      - name: Style check (ruff)
        run: ruff check .
      
      - name: Test coverage
        run: pytest --cov=src/ --cov-report=term
      
      - name: Security check
        run: bash check-secrets.sh .
      
      - name: Run tests
        run: pytest tests/
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage.xml
```

### 12. Documentation Quality [ ]

**README Files:**
- [ ] Project description clear
- [ ] Setup instructions complete
- [ ] Usage examples provided
- [ ] API documentation (docstrings or Swagger)
- [ ] Architecture diagrams
- [ ] Contributing guide
- [ ] License included

**Code Documentation:**
- [ ] Docstrings for all public APIs
- [ ] Inline comments for non-obvious logic
- [ ] Examples in docstrings
- [ ] Type hints complete
- [ ] No TODOs without comments (or with clear action item)

### 13. Git Commit Quality [ ]

**Good commit messages:**
```bash
# GOOD
git commit -m "feat: add user login functionality with password hashing

- Add login endpoint /api/auth/login
- Hash passwords with bcrypt
- Add login tests with valid/invalid credentials
- Add unit tests for password hashing
- Add integration test for login flow
- See: #42"
```

**BAD:**
- "wip" (work in progress)
- "fix bug" (too vague)
- "cleanup" (what was cleaned?)
- All caps with exclamation "BUG FIX!!!1!"

**Conventional Commits:**
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Formatting (Black, etc.)
- `refactor:` Code restructuring
- `test:` Test additions
- `chore:` Maintenance tasks

### 14. Reviewer Checklist [ ]

When reviewing code:

**Fast Checks (5 min):**
- [ ] Code formatted?
- [ ] Tests pass?
- [ ] No obvious typos
- [ ] Commit message clear?

**Deeper Review (30 min):**
- [ ] Tests cover edge cases?
- [ ] Error handling appropriate?
- [ ] Logging helpful?
- [ ] Security considerations addressed?
- [ ] Code follows existing patterns?

**Questions to ask:**
1. "What edge cases have you tested?"
2. "How does this interact with existing functionality?"
3. "What happens when [edge case] occurs?"
4. "Are database connections properly cleaned up?"
5. "Is user input validated?"
6. "Could this introduce security vulnerabilities?"
7. "Does this break backward compatibility?"

**Code Review Template:**
```markdown
## Code Review: [PR Number]

### Summary

[Developer: Brief overview of change.]

[Reviewer: Changes look good overall. One concern about error handling.]

### Concerns

1. **Error handling:** Consider catching `DatabaseConnectionError` specifically
2. **Edge case:** Test what happens when user ID is empty
3. **Logging:** Add more context to log message

### Approved

Changes approved for merge.
```

## Automated Script (QA Reviewer)

```bash
#!/usr/bin/env bash
# qa_reviewer_checklist.sh
# Automated QA tester review checklist

set -e

echo "📋 QA Reviewer Checklist"
echo ""

echo "=== Automated Checks ==="
echo "1. Format check (Black)..."
if black --check --diff . 2>/dev/null; then
    echo "   ✅ PASSED"
else
    echo "   ❌ FAILED - Run: black --fix ."
    exit 1
fi

echo "2. Type check (mypy)..."
mypy --ignore-missing-imports . 2>/dev/null || true
echo "   ⚠️  Report generated (not blocking)"

echo "3. Security check..."
if python3 utilities/check-secrets.sh . 2>/dev/null; then
    echo "   ✅ PASSED"
else
    echo "   ❌ FAILED - Remove hardcoded credentials"
    exit 1
fi

echo "4. Style check (ruff)..."
ruff check . 2>/dev/null || true

echo ""
echo "=== Manual Review Checklist ==="
echo ""
echo "Code Quality:"
echo "  [ ] Docstrings present"
echo "  [ ] Error messages informative"
echo "  [ ] No commented-out code"
echo "  [ ] No print() statements"
echo "  [ ] Logic handles edge cases"
echo ""
echo "Security:"
echo "  [ ] No hardcoded credentials"
echo "  [ ] SQL queries parameterized"
echo "  [ ] External inputs validated"
echo ""
echo "Tests:"
echo "  [ ] All tests pass"
echo "  [ ] Edge cases covered"
echo "  [ ] Coverage >= 80% (critical paths)"

echo ""
echo "=== Next Steps ==="
echo "  - Review code quality checklist above"
echo "  - Verify tests cover edge cases"
echo "  - Check security concerns addressed"
echo "  - Commit if ready: git commit"
echo ""
echo "📋 For detailed checklist: qa_reviewer_checklist.md"
