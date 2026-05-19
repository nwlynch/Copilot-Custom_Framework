---
name: python-qa-guardrails
description: Comprehensive guardrails for novice Python programmers and QA testers to produce quality, well-formatted code aligning with PEP 8, type safety, and enterprise standards. Enforces code quality verification, best practices, pre-commit gates, security scanning, and enterprise Python patterns before code submission.
version: 2.0.0
author: Neville Lynch
license: MIT
platforms: [linux, macos, windows]
tags: [python, qa, testing, pep8, quality-gates, novices, education, code-review, types, enterprise-patterns]
metadata:
  hermes:
    tags: [python, qa, testing, pep8, novices, education]
    related_skills: [test-driven-development, requesting-code-review, github-pr-workflow, codebase-inspection]
  files: [skills/best-practices/testing-patterns.md, skills/code-quality-verifier/python-style-checker.py, skills/code-quality-verifier/function-signatures.py, skills/code-review/qa-reviewer-checklist.md, skills/pre-commit-hooks/.stylebot.toml, skills/python-qa-guardrails/SKILL.md, skills/python-quality-checking/SKILL.md, skills/training/python-basics-for-qa.md, skills/training/pytest-fundamentals.md, skills/training/type-hints-for-beginners.md, skills/training/security-basics.md, skills/training/enterprise-python-patterns.md]
---

# Python QA Guardrails for Novice Programmers

## Overview

This comprehensive skill collection provides **guardrails for novice Python programmers**, especially QA testers who need to produce **quality, well-formatted code** that:

- ✅ Follows **PEP 8** style guidelines
- ✅ Uses **type hints** for all functions
- ✅ Has **comprehensive docstrings**
- ✅ Tests **all edge cases**
- ✅ Handles **exceptions properly**
- ✅ Avoids **security vulnerabilities**
- ✅ Follows **enterprise design patterns**
- ✅ Has **high test coverage**

## What Makes This Essential for QA Testers

QA testers who write Python code often need to:

1. **Validate test data** with proper type checking
2. **Handle edge cases** systematically (not just happy paths)
3. **Write clear assertions** that document behavior
4. **Understand code quality** standards before pushing
5. **Self-review** code before peer review
6. **Avoid common mistakes** like:
   - Silently ignoring exceptions
   - Hardcoding credentials
   - Missing input validation
   - Poor error messages
7. **Use security scanning** before commits
8. **Follow enterprise patterns** for testability

This skill collection provides all the guardrails to prevent these mistakes.

## Quick Start

```bash
# Clone this repository
git clone https://github.com/nwlynch/Python-QA-Guardrails.git
cd Python-QA-Guardrails

# Install dependencies (optional)
pip install -r requirements.txt

# Run quick verification
python3 skills/code-quality-verifier/python-style-checker.py .

# Run full quality checks
bash skills/utilities/qa-reviewer-checklist.sh

# Generate test
pytest tests/
```

## Directory Structure

```
Python-QA-Guardrails/
├── README.md                              # This file
├── requirements.txt                       # Python dependencies
├── .git-hooks/                           # Git hook templates
│   ├── pre-commit                         # Pre-commit script
│   ├── pre-commit-config.yaml            # Pre-commit config
│   └── qa-reviewer-checklist.sh          # Automated checklist
├── skills/                               # Skills collection
│   ├── best-practices/
│   │   └── testing-patterns.md           # QA testing patterns
│   ├── code-quality-verifier/
│   │   ├── python-style-checker.py       # PEP 8 compliance
│   │   ├── function-signatures.py        # Type hint checker
│   │   └── code-smell-detector.py        # DRY, nesting detection
│   ├── code-review/
│   │   └── qa-reviewer-checklist.md      # QA checklist
│   ├── pre-commit-hooks/
│   │   ├── .stylebot.toml                # PEP 8 config
│   │   ├── .black.toml                   # Black formatter config
│   │   ├── pre-commit-hooks.yaml         # Pre-commit hooks
│   │   └── quality-gates.md              # Quality gate rules
│   ├── python-qa-guardrails/             # Main skill documentation
│   │   └── SKILL.md                      # Guardrails skill
│   ├── python-quality-checking/          # Quality gates
│   │   └── SKILL.md                      # Quality verification
│   ├── training/
│   │   ├── python-basics-for-qa.md       # Python basics
│   │   ├── pytest-fundamentals.md        # Testing basics
│   │   ├── type-hints-for-beginners.md   # Python typing
│   │   ├── exception-handling.md         # Error handling
│   │   ├── enterprise-python-patterns.md # Enterprise patterns
│   │   ├── security-basics.md            # Security for QA
│   │   └── testing-patterns.md           # QA-specific patterns
│   ├── utilities/
│   │   ├── format-python.sh              # Format with Black
│   │   ├── check-types.sh                # Run mypy
│   │   ├── check-secrets.sh              # Scan for secrets
│   │   ├── test-single.sh                # Test single file
│   │   └── coverage-report.sh            # Coverage report
│   └── examples/                         # Example code
└── exercises/
    ├── module1/                          # Basic exercises
    ├── module2/                          # Testing exercises
    ├── module3/                          # Type hints
    ├── module4/                          # Security
    ├── module5/                          # Exceptions
    └── solutions/                        # Exercise solutions
```

## Core Components

### 1. Python QA Guardrails (Main Skill)

Located in `skills/python-qa-guardrails/`

**Purpose:** Comprehensive skill for QA testers to produce quality code

**Features:**
- ✅ Code quality verification
- ✅ Type safety checks
- ✅ Security scanning
- ✅ Pre-commit automation
- ✅ Test coverage enforcement
- ✅ Enterprise patterns
- ✅ QA-specific best practices

**How to use:**

```bash
# Before each commit
bash skills/code-review/qa-reviewer-checklist.sh

# Or use automated script
bash utilities/qa-reviewer-checklist.sh
```

### 2. Code Quality Verifier

Located in `skills/code-quality-verifier/`

**Purpose:** Enforce code quality standards

**Files:**
- `python-style-checker.py` — PEP 8 compliance check
- `function-signatures.py` — Type hint verification
- `docstring-checker.py` — Docstring completeness
- `code-smell-detector.py` — DRY, nesting, magic numbers

**Usage:**

```bash
# Check PEP 8 compliance
python3 skills/code-quality-verifier/python-style-checker.py src/

# Check type hints
python3 skills/code-quality-verifier/function-signatures.py src/

# Run all checks
bash utilities/qa-reviewer-checklist.sh
```

### 3. Code Review Checklist

Located in `skills/code-review/`

**Purpose:** Review checklist before push/merge

**Checklist covers:**

| Category | Check Items |
|--|--|--|
| **Automated Checks** | Black, ruff, mypy, security, coverage |
| **Code Quality** | Docstrings, error messages, edge cases |
| **Security** | No hardcoded creds, SQL injection |
| **Style** | Magic numbers, function length |
| **Performance** | Database connections, file handles |

**Usage:**

```bash
# Automated review
bash utilities/qa-reviewer-checklist.sh

# Manual review: open checklist
cat skills/code-review/qa-reviewer-checklist.md
```

### 4. Training Modules

Located in `skills/training/`

**Purpose:** Teach QA testers to write quality Python

**Modules:**

| Module | File | Topics | Time |
|--|--|--|--|
| **Python Basics** | `python-basics-for-qa.md` | Syntax, types, docstrings | 2h |
| **Testing Fundamentals** | `pytest-fundamentals.md` | pytest, fixtures, asserts | 2h |
| **Type Hints** | `type-hints-for-beginners.md` | typing module, mypy | 1.5h |
| **Exception Handling** | `exception-handling.md` | Specific errors, logging | 1.5h |
| **Enterprise Patterns** | `enterprise-python-patterns.md` | DI, repository, factory | 3h |
| **Security Basics** | `security-basics.md` | Secrets, validation | 2h |

**Usage:**

```bash
# Follow modules in order
cd skills/training/
cat python-basics-for-qa.md
cat pytest-fundamentals.md
cat type-hints-for-beginners.md
cat security-basics.md
cat exception-handling.md
cat enterprise-python-patterns.md
```

### 5. Utilities

Located in `skills/utilities/`

**Purpose:** Automation scripts

**Scripts:**

| Script | Purpose | Usage |
|--|--|--|--|
| `format-python.sh` | Format with Black | `black src/` |
| `check-types.sh` | Run mypy | `mypy src/` |
| `check-secrets.sh` | Scan secrets | Security |
| `test-single.sh` | Test single file | `pytest tests/file.py` |
| `coverage-report.sh` | Coverage report | `pytest --cov=src/` |

### 6. Pre-commit Hooks

Located in `skills/pre-commit-hooks/`

**Purpose:** Automated quality gates before commit

**Files:**
- `.stylebot.toml` — PEP 8 config
- `.black.toml` — Black formatter
- `pre-commit-hooks.yaml` — Pre-commit hooks
- `quality-gates.md` — Quality gate rules

**Usage:**

```bash
# Configure pre-commit hooks
cd skills/pre-commit-hooks/
cat .stylebot.toml      # Config
cat pre-commit-hooks.yaml     # Hook config

# Add hooks to git repo
bash utilities/install-hooks.sh

# Pre-commit will run automatically
git commit -m "feat: new feature"
```

## Usage Workflows

### Workflow 1: Manual Review

Before pushing code:

```bash
# Run quality checks
bash utilities/qa-reviewer-checklist.sh

# Review output
# Fix any issues

# Push
git add .
git commit -m "feat: new feature"
```

### Workflow 2: Automated Pre-commit

Add hook templates to `.git/hooks/pre-commit`:

```bash
#!/bin/bash
set -e

# Format
black --check --diff .

# Type check
mypy --ignore-missing-imports .

# Security
bash utilities/check-secrets.sh .

# Tests
pytest tests/

# Style (ruff)
ruff check .

# Coverage
pytest --cov=src/ --cov-report=term

# If all pass, allow commit
git add -u
git commit
```

### Workflow 3: CI/CD Integration

Example GitHub Actions workflow (`.github/workflows/python-qas.yml`):

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
      
      - name: Security check
        run: bash utilities/check-secrets.sh .
      
      - name: Test coverage
        run: pytest --cov=src/ --cov-fail-under=80
      
      - name: Run tests
        run: pytest tests/
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage.xml
```

## Quality Gates

Before code commit, these gates must pass:

### Gate 1: Formatting (Black)

```bash
black --check --diff .
```

**Fails if:**
- Any file unformatted
- Import groups wrong
- Line > 88 chars

### Gate 2: Type Hints (mypy)

```bash
mypy --ignore-missing-imports .
```

**Fails if:**
- Function without type hints
- Type mismatch
- Type comments outdated

### Gate 3: Security

```bash
bash utilities/check-secrets.sh .
```

**Fails if:**
- Hardcoded passwords
- API keys in code
- Private SSH keys
- `.env` files in git

### Gate 4: Style (ruff)

```bash
ruff check .
```

**Fails if:**
- Magic number warnings
- Unnecessary `else`
- Unused imports
- Missing blank lines

### Gate 5: Test Coverage

```bash
pytest --cov=src/ --cov-report=term
```

**Fails if:**
- Critical paths < 90%
- General code < 80%
- Missing edge case tests

## Code Examples

### Before Fixing

```python
# BAD - No type hints, no docstring
def fetch_user(user_id):
    try:
        return query_user(user_id)
    except:
        return None
```

### After Fixing

```python
# GOOD - Type hints, docstring, specific errors
def fetch_user(user_id: str) -> Optional[User]:
    """
    Fetch a user by ID from database.
    
    Args:
        user_id: User ID
        
    Returns:
        User object or None if not found
        
    Raises:
        UserNotFoundError: If user doesn't exist
        DatabaseConnectionError: If database unavailable
    """
    try:
        return query_user(user_id)
    except UserNotFoundError:
        raise
    except DatabaseConnectionError as e:
        logger.error(f"Database connection failed: {e}")
        raise
    except Exception as e:
        logger.critical(f"Unexpected error fetching user: {e}")
        raise
```

## Common Mistakes

| Mistake | How to Fix |
|--|--|--|
| **Hardcoded password** | Use environment variables |
| **Bare except block** | Catch specific exception |
| **Missing type hint** | Add `-> int` |
| **No docstring** | Add PEP 257 docstring |
| **SQL injection** | Use parameterized queries |
| **Silent failure** | Log and raise error |
| **Too deep nesting** | Use guard clauses |
| **Magic numbers** | Use constants |
| **No test coverage** | Add edge case tests |
| **Print instead of logger** | Use `logger` |

## Training Path

### Beginner (No Python?)

**Start here:**

1. Module 1: `python-basics-for-qa.md`
2. Do exercises in `exercises/module1/`
3. Module 2: `pytest-fundamentals.md`
4. Security: `security-basics.md`
5. Type hints: `type-hints-for-beginners.md`
6. Enterprise: `enterprise-python-patterns.md`

**Certificate of Completion:** All modules passed

### Intermediate (Some Python?)

**Skip Python basics:**

1. Module 2: Pytest fundamentals
2. Security first
3. Type hints
4. Enterprise patterns
5. Advanced exercises

### Advanced (Know Python?)

**Focus on:**

1. Security patterns
2. Enterprise patterns
3. Code review checklist
4. Best practices
5. Performance optimization

### Complete Training Timeline

| Day | Module | Time |
|--|--|--|
| **Day 1** | Module 1: Python Basics | 2h |
| **Day 2** | Module 2: Pytest Fundamentals | 2h |
| **Day 3** | Module 3: Security | 2h |
| **Day 4** | Module 4: Type Hints | 1.5h |
| **Day 5** | Module 5: Enterprise | 3h |
| **Day 6** | Review & Exercises | 3h |
| **Total** | | **15.5h** |

## Exercises and Tests

**Location:** `skills/training/exercises/`

**Run tests:**

```bash
# Run all exercises
pytest skills/training/exercises/

# Run specific suite
pytest skills/training/exercises/module1/

# Show progress
pytest skills/training/exercises/ -v

# Coverage
pytest skills/training/exercises/ --cov=exercises/
```

**Solutions:** `skills/training/exercises/solutions/`

**Example exercise:**

```python
# exercises/module1/calculator.py
def add(a: int, b: int) -> int:
    """Add two integers."""
    return a + b

def test_add_positive():
    assert add(2, 3) == 5

def test_add_negative():
    assert add(-2, -3) == -5
```

## Best Practices

### 1. Write Tests First (TDD)

See `skills/best-practices/testing-patterns.md`

```python
# Write failing test first
def test_calculate_total():
    """Test calculating total."""
    # Should fail before implementation
    products = [
        {"name": "apple", "price": 1.00},
        {"name": "banana", "price": 0.50},
    ]
    assert calculate_total(products) == 1.50
```

### 2. Use Type Hints Everywhere

See `skills/training/type-hints-for-beginners.md`

```python
# All parameters and return types
def get_user(user_id: str) -> Optional[User]:
    ...

def login(email: str, password: str) -> bool: ...

with pytest.raises(ValueError):
    ...
```

### 3. Never Hardcode Secrets

See `skills/training/security-basics.md`

```python
# BAD
user = "admin"
password = "secret123"  # Never!

# GOOD
import os
user = os.environ.get("DB_USER")
password = os.environ.get("DB_PASSWORD")
```

### 4. Specific Exception Handling

See `skills/training/exception-handling.md`

```python
# BAD
try:
    ...
except:
    pass  # What happened?!

# GOOD
try:
    ...
except UserNotFoundError as e:
    logger.info(f"User not found: {e}")
except DatabaseConnectionError as e:
    logger.warning(f"Database unavailable: {e}")
```

### 5. Validate All Inputs

See `skills/training/security-basics.md`

```python
# BAD
def login(email, password):
    ...

# GOOD
def login(email: str, password: str) -> bool:
    if not email or not is_valid_email(email):
        raise ValidationError("Invalid email")
    if len(password) < 8:
        raise ValidationError("Password too short")
    ...
```

## Quick Reference

| Task | Command |
|--|--|--|
| **Format code** | `black src/` |
| **Type check** | `mypy src/` |
| **Fix style** | `black --fix src/` |
| **Test** | `pytest tests/` |
| **Coverage** | `pytest --cov=src/` |
| **Security** | `check-secrets.sh` |
| **Style check** | `ruff check .` |
| **Full check** | `qa-reviewer-checklist.sh` |

## License

MIT License

## Related Skills

- `test-driven-development` — Write tests first
- `requesting-code-review` — Pre-commit verification
- `github-pr-workflow` — PR workflow
- `codebase-inspection` — Code quality checks

## Support

- **GitHub Copilot**: Use AI for guidance
- **Type hints**: `typing` module docs
- **pytest**: Testing documentation
- **Security**: OWASP top 10
- **Code review**: Pull request guides
- **Community**: Python QA Discord

## Changes from v1.x

**v2.0 Improvements:**

- ✅ Better documentation
- ✅ More examples
- ✅ Exercise solutions
- ✅ CI/CD templates
- ✅ Security patterns
- ✅ Complete training modules
