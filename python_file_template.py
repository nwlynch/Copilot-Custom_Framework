# Python Startup Template
# ==============================================================================
# This is a template for creating Python files in GitHub Copilot sessions
# Follow the rules in python_startup_guide.md
# ==============================================================================
"""Module docstring explaining what this module does.

Args:
    (optional): If module-level variables exist.

Returns:
    None (for modules)
"""

# ==============================================================================
# STANDARD LIBRARY IMPORTS (ordered)
# ==============================================================================
from __future__ import annotations  # Enable newer Python syntax

import logging
import sys
from pathlib import Path

# ==============================================================================
# THIRD-PARTY IMPORTS (alphabetically)
# ==============================================================================
import requests  # Example: HTTP client
# import numpy as np  # Example: numerical computing
# import pandas as pd  # Example: data analysis

# ==============================================================================
# LOCAL/PROJECT IMPORTS (alphabetically)
# ==============================================================================
from myproject.config import CONFIG  # Example: project config
# from myapp.models import User  # Example: local models
# from myapp.utils import validators  # Example: utility functions

# ==============================================================================
# LOGGING SETUP
# ==============================================================================
logger = logging.getLogger(__name__)


# ==============================================================================
# FUNCTIONS
# ==============================================================================
def function_name(parameter1: int, parameter2: str) -> str:
    """Docstring describing the function's purpose.

    Args:
        parameter1 (int): Description of parameter 1.
        parameter2 (str): Description of parameter 2.

    Returns:
        str: Description of return value.

    Raises:
        ValueError: Description of when this exception is raised.
    """
    # Function implementation
    result = parameter1 * 2
    return str(result) + ": " + parameter2


# ==============================================================================
# CLASSES (if applicable)
# ==============================================================================
class ClassName:
    """Docstring describing the class's purpose and behavior.

    Attributes:
        attribute1 (type): Description of attribute 1.
        attribute2 (type): Description of attribute 2.
    """

    def __init__(self, parameter1: int, parameter2: str) -> None:
        """Initialize the class instance.

        Args:
            parameter1 (int): Description of parameter 1.
            parameter2 (str): Description of parameter 2.
        """
        self._attribute1 = parameter1
        self._attribute2 = parameter2

    @property
    def attribute1(self) -> int:
        """Get the attribute 1 value."""
        return self._attribute1

    @attribute1.setter
    def attribute1(self, value: int) -> None:
        """Set the attribute 1 value."""
        self._attribute1 = value


# ==============================================================================
# TYPE HINTED VARIABLES (use sparingly, only when needed)
# ==============================================================================
# CONSTANT = "Example constant"  # Only for immutable, global constants
# CONFIG_LIST: list[int] = [1, 2, 3]  # Only when type matters


# ==============================================================================
# ENTRY POINT (if applicable)
# ==============================================================================
if __name__ == "__main__":
    # Main execution code
    logger.info("Running main entry point")
    
    # Example usage
    result = function_name(10, "Hello")
    print(f"Result: {result}")


# ==============================================================================
# DOCS: How to use this template
# ==============================================================================
# 1. Replace example code with your actual implementation
# 2. Add type hints to ALL function parameters and return values
# 3. Add docstrings to ALL functions and classes
# 4. NEVER delete existing type hints - they prevent AI guessing
# 5. Add only imports that are actually used
# 6. Use property decorators for instance attributes when possible
# 7. Use logging instead of print statements
# 8. Follow the import order above
# 9. For functions: always validate inputs and handle errors
# 10. For classes: use _ prefix for private attributes
# ==============================================================================
