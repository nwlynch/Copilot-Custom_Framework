# Copilot Python Configuration & QA Guardrails Framework

## 📋 Overview

This framework combines two essential components for professional Python development:

1. **Python Configuration Framework** - PEP 8 compliant code layout with industry standards
2. **Python QA Guardrails Skills** - Comprehensive quality assurance guardrails for novice programmers

## 🎯 Quick Start

```bash
# 1. Review Python Startup Guide
cat python_startup_guide.md

# 2. Read Copilot Session Rules
cat copilot_session_rules.md

# 3. Use the Python Template
cat python_file_template.py

# 4. For QA Testing: Read the Skills Documentation
cat skills/README.md
```

---

## 📁 Core Framework Files

| File | Purpose |
|---|---|
| `copilot_python_config.ini` | Python configuration settings |
| `copilot_session_rules.md` | Coding standards and session guidelines |
| `python_file_template.py` | Standard Python file template |
| `python_startup_guide.md` | Setup instructions for developers |
| `requirements.txt` | Python dependencies |

---

## 🛡️ Python QA Guardrails Skills

The `skills/` folder contains comprehensive quality assurance guardrails for novice Python programmers and QA testers.

### 📚 What's Included

| Folder | Content |
|---|---|
| **`skills/python-qa-guardrails/`** | Main guardrails skill with code quality standards |
| **`skills/python-quality-checking/`** | Quality verification utilities |
| **`skills/best-practices/`** | Testing patterns and best practices |
| **`skills/code-review/`** | QA review checklists and guidelines |
| **`skills/pre-commit-hooks/`** | Pre-commit quality gates |
| **`skills/training/`** | Training modules for QA testers |
| **`skills/utilities/`** | Helper scripts for quality checks |

### ✨ Key Features

- ✅ **PEP 8 Enforcement** - Black formatting and style checks
- ✅ **Type Hints** - All functions require type annotations
- ✅ **Security Scanning** - Detect hardcoded credentials
- ✅ **Edge Case Testing** - Systematic test coverage
- ✅ **Exception Handling** - Specific error types, not bare except
- ✅ **Enterprise Patterns** - Dependency injection, repository pattern
- ✅ **Pre-commit Gates** - Automated quality before git push

### 🎓 Training Modules

**For QA Testers (5 Modules):**

1. **Module 1:** `training/python-basics-for-qa.md` - Python fundamentals (2h)
2. **Module 2:** `training/pytest-fundamentals.md` - Testing basics (2h)
3. **Module 3:** `training/security-basics.md` - Security patterns (2h)
4. **Module 4:** `training/type-hints-for-beginners.md` - Type annotations (1.5h)
5. **Module 5:** `training/enterprise-python-patterns.md` - Enterprise patterns (3h)

**Total Training Time:** ~10.5 hours

---

## 🚀 Usage Instructions

### For Development

```bash
# 1. Create new Python files using template
cp python_file_template.py src/my_module.py
cat src/my_module.py  # Review and customize

# 2. Format code with Black
black -l 88 src/

# 3. Type check
mypy --ignore-missing-imports src/

# 4. Security scan (check for hardcoded secrets)
cd skills/
./utilities/check-secrets.sh .

# 5. Run tests
pytest src/ --cov=src/ --cov-report=term-missing
```

### For QA Testing

```bash
# Run code quality verification
cd skills/
./code-review/qa-reviewer-checklist.sh

# View test patterns
cat skills/best-practices/testing-patterns.md

# Read QA reviewer checklist
cat skills/code-review/qa-reviewer-checklist.md
```

### For Code Review

Before submitting code for review, verify:

```bash
#!/bin/bash
# QA Review Checklist
echo "=== QA Review Checklist ==="
echo "✅ PEP 8 compliant (Black + ruff)"
echo "✅ Type hints present on all functions"
echo "✅ No hardcoded secrets or credentials"
echo "✅ Docstrings document behavior"
echo "✅ Input validation present"
echo "✅ Exceptions handled explicitly"
echo "✅ Test coverage >= 80%"
```

---

## 📖 Documentation Guide

### Essential Reading (Start Here)

1. **`python_startup_guide.md`** - Get started with the framework
2. **`copilot_session_rules.md`** - Understand coding standards
3. **`skills/python-qa-guardrails/SKILL.md`** - Python QA guardrails overview
4. **`skills/best-practices/testing-patterns.md`** - QA testing patterns
5. **`skills/code-review/qa-reviewer-checklist.md`** - Review guidelines

### Training Path

- **Day 1-2:** Python basics and pytest (training/)
- **Day 3-4:** Testing patterns and quality gates (best-practices/)
- **Day 5:** Security and enterprise patterns (training/)

### Quick Reference

| Need | Documentation |
|---|---|
| Input validation | `skills/best-practices/validation-patterns.md` |
| Exception handling | `skills/training/exception-handling.md` |
| Database queries | `skills/best-practices/database-testing.md` |
| API testing | `skills/best-practices/api-testing-patterns.md` |
| Enterprise patterns | `training/enterprise-python-patterns.md` |
| Pre-commit hooks | `skills/pre-commit-hooks/` |

---

## 🔧 Utility Scripts Location

Scripts are in `skills/utilities/`:

| Script | Usage |
|---|---|
| `format-python.sh` | Format code with Black |
| `check-types.sh` | Run mypy type checker |
| `check-secrets.sh` | Scan for hardcoded secrets |
| `test-single.sh` | Test single file/module |
| `coverage-report.sh` | Report test coverage |

**Example Pre-commit Hook:**

```bash
# Add to .git/hooks/pre-commit
#!/bin/bash
cd /home/nwlynch/Copilot-Custom_Framework

# Format code
black -l 88 . || exit 1

# Type check
mypy --ignore-missing-imports . || exit 1

# Security scan
./skills/utilities/check-secrets.sh . || exit 1

# Run tests
pytest . --cov=. --cov-fail-under=80 || exit 1

exit 0
```

---

## 🌟 Changes & Updates

### What's New

- ✅ **Complete QA Guardrails Skills Collection** Added
- ✅ **Training Modules** Created for QA testers
- ✅ **Utility Scripts** For automated quality checks
- ✅ **Pre-commit Hooks** Integration ready
- ✅ **Best Practices Catalog** With testing patterns
- ✅ **Enterprise Patterns** Documentation

### Previous Version

**v1.0** - Basic Python configuration

**Current Version** - v2.0 - Comprehensive QA capabilities

---

## 💡 Integration with Hermes Agent

Use these skills with Hermes AI agent for automated code review:

```python
from hermes import delegate_task

# Code review with QA guardrails
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
    """,
    toolsets=['terminal', 'file']
)
```

---

## 📝 Contributing

1. Read existing documentation first
2. Follow `python_file_template.py` structure
3. Run quality checks before committing
4. Update documentation as needed

---

## 📜 License

See project root for license information.

---

## 📞 Support

For issues or questions:
- Check `copilot_session_rules.md`
- Review `skills/python-qa-guardrails/SKILL.md`
- Ask in project communication channel

---

*Last updated: May 2026*
*Version: 2.0 - With QA Guardrails Skills*
