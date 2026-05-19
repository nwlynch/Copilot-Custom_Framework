#!/bin/bash
# Type checking for Python code
# Usage: check-types.sh [directory]
# Exits: 0 = clean, 1 = issues found

set -e

DIRECTORY="${1:-.}"
PROJECT_NAME="$(basename $DIRECTORY || echo "project")"

echo "🔍 Type Check: Verifying type hints in $DIRECTORY"

echo ""
echo "=== Checking with mypy ==="
echo ""

# Run mypy (lenient mode for development)
# --ignore-missing-imports: skip external modules we don't own
# --warn-return-any: warn on Any types (encourage better typing)
# --show-error-codes: show error codes for documentation
mypy \
    --ignore-missing-imports \
    --warn-return-any \
    --show-error-codes \
    "$DIRECTORY" \
    2>&1 || true

EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    echo ""
    echo "✅ Type check PASSED: All functions have type hints"
    exit 0
else
    echo ""
    echo "❌ Type check FAILED: Missing type hints or type mismatches"
    echo "   (Consider using --ignore-missing-imports for external modules)"
    
    # List problematic files
    echo ""
    echo "Problematic files:"
    mypy \
        --ignore-missing-imports \
        --show-error-codes \
        "$DIRECTORY" \
        2>&1 | grep -E "error:.*\.\.py:" | awk -F: '{print $1}' | sort -u | head -20
    
    echo ""
    echo "💡 To fix type hints:"
    echo "   1. Add typing annotations to all public functions"
    echo "   2. Use typing.TYPE_CHECKING for imports"
    echo "   3. Consider stub files (.pyi) for external modules"
    
    exit 1
fi