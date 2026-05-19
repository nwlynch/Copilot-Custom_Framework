---
name: python-quality-checking
description: Enforce PEP 8 code quality verification, type hints, test coverage, and security scanning before code submission for Python QA testers and novices.
version: 1.0.0
author: Neville Lynch
license: MIT
platforms: [linux, macos, windows]
tags: [python, pep8, quality, verification, novices, qa, formatting, types, security, testing]
metadata:
  hermes:
    tags: [python, pep8, quality, verification, novices, qa]
    related_skills: [test-driven-development, requesting-code-review, github-pr-workflow]
---

# Python Code Quality Verification

## Overview

This skill enforces **PEP 8 code quality standards** before code submissions. It verifies:

- ✅ PEP 8 style compliance (Black formatter)
- ✅ Type hints present on all functions
- ✅ No hardcoded secrets or credentials
- ✅ Comprehensive docstrings
- ✅ Test coverage meets thresholds
- ✅ Security vulnerability scan

## When to Use

**Run before commit:**
- After implementing a feature
- After fixing a bug
- After refactoring code
- Before push to origin

**Auto-run patterns:**
- User says "commit" or "push"
- `requesting-code-review` skill invoked
- After `write_file` with multiple changes

**Skip when:**
- User explicitly says "skip quality check"
- Documentation-only changes
- Pure configuration updates

## Quality Gates

### Gate 1: Formatting (Black)

All code must be formatted with Black:

```bash
black -l 88 .  # 88-char line limit
```

**Fails if:**
- Any file lacks `# fmt: off` markers
- Imports not grouped correctly
- Line length > 88 characters

### Gate 2: Type Hints (mypy)

All public functions and classes must have type hints:

```bash
mypy --ignore-missing-imports .  # Lenient mode
```

**Fails if:**
- Function without type hints
- Class without type hints
- Union types not using `|` operator
- Missing `Optional[T]` annotations

### Gate 3: Style (ruff)

PEP 8 compliance with ruff:

```bash
ruff check .
ruff check . --preview  # Preview rules
```

**Fails if:**
- Magic number warnings
- Unnecessary `else` after return
- Missing blank lines between functions
- Unused imports

### Gate 4: Security (Secrets)

Scan for common security issues:

```bash
python3 utilities/check-secrets.sh .
```

**Fails if:**
- Hardcoded passwords found
- API keys in source code
- Private SSH keys present
- `.env` files in git

### Gate 5: Test Coverage (pytest)

Ensure code is tested adequately:

```bash
pytest --cov=src/ --cov-report=term
```

**Target:**
- Critical paths: >= 90%
- General code: >= 80%
- Optional code: >= 50%

**Excluded:**
- Private methods (underscore prefix)
- Stub `...` functions
- Mock objects

## Quick Commands

### Full Quality Gate

```bash
# Run all quality gates
./utilities/check-types.sh . && \
./utilities/check-secrets.sh . && \
ruff check . && \
pytest . --cov=src/ -q
```

### Format Only

```bash
black -l 88 .
```

### Type Check Only

```bash
mypy --ignore-missing-imports .
```

### Style Check Only

```bash
ruff check .
```

### Coverage Report

```bash
pytest tests/ \
  --cov=src/ \
  --cov-report=term-missing \
  --cov-report=html:coverage.html
```

## Integration with Other Skills

### Pre-Commit Hook

Add to `.git/hooks/pre-commit`:

```bash
#!/bin/bash
set -e

./utilities/format-python.sh .
./utilities/check-types.sh src/
./utilities/check-secrets.sh .
pytest tests/
ruff check .

git add -u
git commit
```

### Auto-Fix Loop

When quality gate fails:

1. Identify failing check
2. Fix the issue:
   - Formatting: `black src/`
   - Types: Add type hints
   - Style: `ruff check --fix .`
   - Secrets: Remove/validate credentials
   - Coverage: Add missing tests
3. Re-run quality gate
4. Push after all pass

### With `requesting-code-review`

Use this skill before invoking `requesting-code-review`:

```bash
# Ensure quality gates pass first
black -l 88 .
ruff check --fix .
mypy --ignore-missing-imports .
pytest -q .
```

This ensures code is ready for review.

## Code Quality Checklist

Before each push, verify:

- [ ] PEP 8 compliant (Black pass)
- [ ] Type hints on all public functions
- [ ] No hardcoded secrets
- [ ] Security scan clean
- [ ] Code coverage threshold met
- [ ] All tests pass (`pytest`)
- [ ] No style warnings (ruff)
- [ ] Docstrings present on public APIs
- [ ] Input validation in place

## Common Failures

### Formatting Issues

**Problem:** Line too long

```python
# BAD - Line 105 chars
def calculate_total_price(user_id: str, products: list, quantity: int, 
                        discount_percent: float) -> float:
    # ...

# GOOD - Wrapped at 88 chars
def calculate_total_price(
    user_id: str,
    products: list,
    quantity: int,
    discount_percent: float
) -> float:
    # ...
```

**Fix:** `black src/`

### Type Hint Issues

**Problem:** Missing return type

```python
# BAD
def calculate_total(products: list) -> int:
    ...

# GOOD
def calculate_total(
    products: list[Product],
    quantity: int = 1,
) -> float:
    ...
```

**Fix:** Add type hint
```
