#!/bin/bash
# Check for hardcoded secrets in Python source files
# Usage: check-secrets.sh [directory]
# Exit codes: 0 = clean, 1 = secrets found

set -e

DIRECTORY="${1:-.}"
PROJECT_NAME="$(basename $DIRECTORY || echo "project")"

echo "🔍 Security Check: Scanning for hardcoded secrets in $DIRECTORY"

SECRETS_FOUND=0

# Check for password assignments
echo "🔑 Checking for hardcoded passwords..."
PASSWORDS=$(grep -riE "(password|passwd|pwd)\s*=\s*['\"]" "$DIRECTORY" 2>/dev/null || true)

if [ -n "$PASSWORDS" ]; then
    echo "❌ Found potential passwords:"
    echo "$PASSWORDS" | while read -r line; do
        echo "  → $line"
    done
    SECRETS_FOUND=1
fi

# Check for API keys
echo "🔑 Checking for API keys..."
API_KEYS=$(grep -riE "(api_key|api_token|apikey|secret_key)\s*=\s*['\"][^'\"]{6,}" "$DIRECTORY" 2>/dev/null || true)

if [ -n "$API_KEYS" ]; then
    echo "❌ Found potential API keys:"
    echo "$API_KEYS" | while read -r line; do
        echo "  → $line"
    done
    SECRETS_FOUND=1
fi

# Check for connection strings
echo "🔑 Checking for database connection strings..."
DB_CONNECTIONS=$(grep -riE "(postgresql|mysql|mongodb|redis|amqp)://[^:]+:[^@]+@" "$DIRECTORY" 2>/dev/null || true)

if [ -n "$DB_CONNECTIONS" ]; then
    echo "❌ Found potential database URIs:"
    echo "$DB_CONNECTIONS" | while read -r line; do
        echo "  → $line"
    done
    SECRETS_FOUND=1
fi

# Check for AWS credentials
echo "🔑 Checking for AWS credentials..."
AWS_CREDS=$(grep -riE "(aws_access_key_id|aws_secret_access_key)\s*=\s*['\"][^'\"]+['\"]" "$DIRECTORY" 2>/dev/null || true)

if [ -n "$AWS_CREDS" ]; then
    echo "❌ Found potential AWS credentials:"
    echo "$AWS_CREDS" | while read -r line; do
        echo "  → $line"
    done
    SECRETS_FOUND=1
fi

# Check for private keys
echo "🔑 Checking for private keys..."
if [ -f "$DIRECTORY/ssh_private_key.pem" ] || [ -f "$DIRECTORY/ssh_private_key" ]; then
    echo "❌ Private SSH key file found in directory!"
    SECRETS_FOUND=1
fi

# Check for .env files
echo "🔑 Checking for .env files..."
if [ -f "$DIRECTORY/.env" ]; then
    echo "⚠️  .env file found (should not be in git)"
    SECRETS_FOUND=1
fi

# Check for hardcoded secrets in documentation
echo "🔑 Checking documentation for example credentials..."
EXAMPLE_CREDS=$(grep -riE "(password|secret|api_key)[^a-zA-Z]*:\s*['\"]test" "$DIRECTORY" 2>/dev/null || true)

if [ -n "$EXAMPLE_CREDS" ]; then
    echo "⚠️  Documentation contains example credentials (consider using 'xxx'):
"
    echo "$EXAMPLE_CREDS"
fi

echo ""

if [ $SECRETS_FOUND -eq 1 ]; then
    echo "❌ Security check FAILED: Secrets found in code"
    echo "📖 See: skills/training/security_basics.md"
    echo "📖 See: validation_patterns.md"
    exit 1
else
    echo "✅ Security check PASSED: No hardcoded secrets found"
    echo "   (If this is expected, check gitignore and .env files)"
    exit 0
fi
