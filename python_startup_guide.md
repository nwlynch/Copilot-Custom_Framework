# Python Startup Guide for GitHub Copilot Sessions
# ==============================================================================
# This guide ensures proper code layout and industry standards for novice Python programmers
# ==============================================================================

# ==============================================================================
# IMPORT RULES
# ==============================================================================
#
# 1. Import order (as enforced by isort):
#    - Future imports
#    - Standard library imports (grouped by module)
#    - Third-party imports (alphabetically)
#    - Local/first-party imports (alphabetically)
#    - Project/local folder imports
#
# 2. Example:
#    from __future__ import annotations
#
#    import os
#    import sys
#    from pathlib import Path
#
#    import requests
#    import numpy as np
#
#    from myproject.utils import helper
#    from myapp.models import User
#
# 3. Never import without a clear requirement:
#    - Each import should serve a specific purpose
#    - Import only what you need, not everything from a package
#    - Document the dependency in requirements.txt

# ==============================================================================
# FUNCTION DEFINITION RULES
# ==============================================================================
#
# 1. Every function must have:
#    - A clear docstring explaining its purpose
#    - Type hints for parameters and return values
#    - Type hints should be added as you learn, don't skip them entirely
#    - Clear docstring signature with parameters and return value
#
# 2. Docstring format (PEP 257/258):
#    """
#    Brief description of what the function does.
#
#    Args:
#        param_name (type): Description of parameter.
#        param_name (type): Description of parameter.
#
#    Returns:
#        type: Description of return value.
#
#    Raises:
#        ExceptionType: When exception is raised.
#    """
#
# 3. Function naming:
#    - Use descriptive names that explain WHAT, not HOW
#    - Use snake_case for functions
#    - Prefix with underscore for private functions
#
# 4. Example:
#    def calculate_average_score(scores: list[float]) -> float:
#        """Calculate the average of a list of scores.
#
#        Args:
#            scores (list[float]): List of numerical scores.
#
#        Returns:
#            float: The average score.
#
#        Raises:
#            ValueError: If the scores list is empty.
#        """
#        if not scores:
#            raise ValueError("Scores list cannot be empty")
#
#        return sum(scores) / len(scores)
#
# 5. NO GUARDIAN CLAUSE FUNCTIONS:
#    Avoid patterns like:
#    def process_data(data: dict) -> Optional[dict]:
#        if data is None:
#            return None
#        # process...
#    Instead:
#    def process_data(data: dict | None) -> dict | None:
#        return data if data else None
#
# ==============================================================================
# CLASS DEFINITION RULES
# ==============================================================================
#
# 1. Every class must have:
#    - A clear docstring explaining its purpose
#    - Type hints for __init__ parameters and instance attributes
#    - Property-based accessors for instance attributes (prefer @property)
#
# 2. Example:
#    class User:
#        """A user entity with profile information.
#
#        Attributes:
#            user_id (int): The unique identifier.
#            name (str): The user's full name.
#            email (str): The user's email address.
#        """
#
#        def __init__(self, user_id: int, name: str, email: str) -> None:
#            """Initialize a new User instance.
#
#            Args:
#                user_id (int): The unique identifier.
#                name (str): The user's full name.
#                email (str): The user's email address.
#            """
#            self._user_id = user_id
#            self._name = name
#            self._email = email
#
#        @property
#        def user_id(self) -> int:
#            """Get the user's unique identifier."""
#            return self._user_id
#
#        @property
#        def name(self) -> str:
#            """Get the user's full name."""
#            return self._name
#
# ==============================================================================
# LAYOUT RULES
# ==============================================================================
#
# 1. File structure:
#    - One file per module (one concern per file)
#    - Related but distinct functionality should be in separate files
#    - Example: models.py, services.py, validators.py for a feature
#
# 2. Module organization:
#    app/
#        __init__.py
#        models/          # Data models
#            user.py
#            post.py
#        services/        # Business logic
#            auth.py
#            notification.py
#        controllers/     # Request handlers
#            user.py
#            post.py
#        utils/          # Shared utilities
#            validators.py
#            formatters.py
#
# 3. No circular imports - import from top-level modules only
#
# ==============================================================================
# ERROR HANDLING RULES
# ==============================================================================
#
# 1. Never use bare except:
#    - Always catch specific exceptions
#    - Example: except ValueError as e:
#
# 2. Use logging, not print statements:
#    import logging
#    logger = logging.getLogger(__name__)
#    logger.info("Processing...")
#    logger.error("Something went wrong", exc_info=True)
#
# 3. Validate inputs with clear error messages:
#    def process(data: dict) -> dict:
#        if "id" not in data:
#            raise ValueError("Missing required field: id")
#        return data
#
# ==============================================================================
# TYPE HINTING RULES
# ==============================================================================
#
# 1. Use typing module for complex types:
#    from typing import Optional, List, Dict, Union
#
# 2. Use Python 3.10+ syntax for simple cases:
#    def func(x: int | str) -> None:  # Union[int, str]
#
# 3. Type hint collections:
#    - list[int] instead of List[int] (Python 3.9+)
#    - dict[str, int] instead of Dict[str, int]
#    - Optional[int] for nullable values
#
# ==============================================================================
# DO NOT DO:
# ==============================================================================
#
# 1. NEVER create functions without:
#    - Type hints on parameters
#    - Type hints on return values (except for None, bool, etc.)
#    - A docstring
#
# 2. NEVER use magic numbers:
#    BAD: result = value * 0.95
#    GOOD: result = value * DISCOUNT_RATE
#
# 3. NEVER assume data shapes:
#    BAD: data[0][1]  # assuming list of lists
#    GOOD: data["items"][0]["price"]  # using explicit keys
#
# 4. NEVER import modules just in case you need them:
#    import numpy as np  # don't use
#
#    Instead:
#    from numpy import array  # import only what you need
#
# ==============================================================================