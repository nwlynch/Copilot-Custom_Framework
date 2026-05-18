# GitHub Copilot Session Rules for Python
# ==============================================================================
# These rules must be followed to ensure proper code layout
# ==============================================================================

# ==============================================================================
# RULE 1: NO GUESSING - EVERY FUNCTION MUST HAVE CONFIRMED REQUIREMENTS
# ==============================================================================
#
# ✅ DO:
#   def calculate_area(width: int, height: int) -> int:
#       """Calculate the area of a rectangle.
#
#       Args:
#           width (int): The width of the rectangle.
#           height (int): The height of the rectangle.
#
#       Returns:
#           int: The area (width × height).
#       """
#       return width * height
#
# ❌ DON'T:
#   def process() -> ?  # What are we processing? What type?
#
# ==============================================================================
# RULE 2: TYPE HINTS ARE MANDATORY
# ==============================================================================
#
# ✅ DO:
#   def get_user(user_id: int) -> dict | None:
#
# ❌ DON'T:
#   def get_user(user_id):  # Missing type hints
#       return data  # Missing return type
#
# Type hinting prevents AI from guessing wrong types.
#
# ==============================================================================
# RULE 3: NO BARE FUNCTIONS
# ==============================================================================
#
# ✅ DO:
#   def validate_email(email: str) -> bool:
#
# ❌ DON'T:
#   def check():  # What does check do? What inputs?
#
# Every function must have a name that describes WHAT it does.
#
# ==============================================================================
# RULE 4: DOCSTRINGS ARE REQUIRED
# ==============================================================================
#
# ✅ DO:
#   def fetch_data(url: str) -> dict:
#       """Fetch data from the given URL.
#
#       Args:
#           url (str): The URL to fetch data from.
#
#       Returns:
#           dict: The fetched data as a dictionary.
#       """
#
# ❌ DON'T:
#   def fetch_data(url: str) -> dict:
#       pass  # No docstring, what does it do?
#
# ==============================================================================
# RULE 5: IMPORT ORDER
# ==============================================================================
#
# Order:
# 1. Future imports
# 2. Standard library imports (grouped by module)
# 3. Third-party imports (alphabetically)
# 4. Local/first-party imports (alphabetically)
#
# ✅ DO:
#   from __future__ import annotations
#
#   import os
#   import sys
#   from pathlib import Path
#
#   import requests
#   import numpy as np
#
#   from myproject.utils import helper
#
# ❌ DON'T:
#   import requests
#   import os
#   import sys  # Wrong order!
#
# ==============================================================================
# RULE 6: NO CIRCULAR IMPORTS
# ==============================================================================
#
# ✅ DO:
#   # Import from top-level modules only
#   from myproject.models.user import User
#
# ❌ DON'T:
#   # This creates circular imports
#   from myproject.models.user import User
#   from myproject.models.post import Post  # which imports User
#
# ==============================================================================
# RULE 7: VALIDATE ALL INPUTS
# ==============================================================================
#
# ✅ DO:
#   def process_data(data: dict | None) -> dict | None:
#       if data is None:
#           raise ValueError("Data cannot be None")
#
#       if "id" not in data:
#           raise ValueError("Missing required field: id")
#
# ❌ DON'T:
#   def process_data(data):
#       return data["id"]  # What if "id" doesn't exist?
#
# ==============================================================================
# RULE 8: USE LOGGING, NOT PRINT
# ==============================================================================
#
# ✅ DO:
#   import logging
#   logger = logging.getLogger(__name__)
#   logger.info("Processing started")
#   logger.debug("Data: %s", data)
#
# ❌ DON'T:
#   print("Processing started")  # Wrong!
#
# ==============================================================================
# RULE 9: PROPER EXCEPTION HANDLING
# ==============================================================================
#
# ✅ DO:
#   try:
#       result = risky_operation()
#   except ValueError as e:
#       logger.error("Value error occurred", exc_info=True)
#       return None
#   except Exception as e:
#       logger.error("Unexpected error", exc_info=True)
#       return None
#
# ❌ DON'T:
#   try:
#       risky_operation()
#   except Exception:  # Too broad!
#       pass
#
# ==============================================================================
# RULE 10: FUNCTION NAMING CONVENTIONS
# ==============================================================================
#
# ✅ DO:
#   - Descriptive names: calculate_average_score
#   - Clear intent: validate_email_format
#   - Private functions: _internal_helper
#   - Snake_case: process_user_data
#
# ❌ DON'T:
#   - Magic numbers: process_123
#   - Ambiguous: handle, do_this, maybe_stuff
#   - CamelCase: processUserData  # Wrong for Python!
#
# ==============================================================================
# RULE 11: CONSTANT NAMING
# ==============================================================================
#
# ✅ DO:
#   MAX_RETRIES: int = 3
#   DISCOUNT_RATE: float = 0.95
#   APP_VERSION: str = "1.0.0"
#
# ❌ DON'T:
#   magic_threshold = 10  # Should be MAX_THRESHOLD
#
# ==============================================================================
# RULE 12: CLASS DESIGN
# ==============================================================================
#
# ✅ DO:
#   class User:
#       """A user with profile information.
#
#       Attributes:
#           user_id (int): Unique identifier.
#           name (str): User's full name.
#       """
#
#       def __init__(self, user_id: int, name: str) -> None:
#           """Initialize a User instance.
#
#           Args:
#               user_id (int): The user's unique identifier.
#               name (str): The user's full name.
#           """
#           self._user_id = user_id
#           self._name = name
#
#       @property
#       def user_id(self) -> int:
#           """Get the user's unique identifier."""
#           return self._user_id
#
# ❌ DON'T:
#   class User:
#       self.id = 123  # No type, no private prefix
#
# ==============================================================================
# RULE 13: USE PROPER COLLECTIONS
# ==============================================================================
#
# ✅ DO:
#   users: list[User] = []
#   user_map: dict[str, User] = {}
#   score_range: tuple[float, float] = (0.0, 100.0)
#
# ❌ DON'T:
#   users = []  # Missing type hint
#   score_range = (0.0, 100.0)  # Missing type hint
#
# ==============================================================================
# RULE 14: STRING QUOTES CONSISTENCY
# ==============================================================================
#
# ✅ DO:
#   message = 'Single quotes for strings'
#   docstring = """Triple-quoted strings for docs"""
#
# ❌ DON'T:
#   message = 'Mixed
#   "quotes"  # Inconsistent
#
# ==============================================================================
# RULE 15: BLANK LINE SEPARATION
# ==============================================================================
#
# ✅ DO:
#   # Blank line between sections
#   def function1():
#       pass
#
#   def function2():
#       pass
#
# ❌ DON'T:
#   def function1():
#       pass
#   def function2():  # No blank line between functions
#       pass
#
# ==============================================================================
# RULE 16: LINE LENGTH (88 chars max)
# ==============================================================================
#
# ✅ DO:
#   message = 'This is a very long message that might
#             exceed the line length limit'
#
# ❌ DON'T:
#   message = 'This is a very long message that exceeds the line length limit
#              without wrapping'
#
# ==============================================================================
# RULE 17: COMMENT BEST PRACTICES
# ==============================================================================
#
# ✅ DO:
#   # Complex logic explanation
#   # Temporary TODOs only when necessary
#   """Module docstring explaining purpose"""
#
# ❌ DON'T:
#   # TODO: (Remove this when done)  # Don't leave TODOs
#   # FIXME: This is broken  # Don't leave FIXMEs without fixing
#   # TODO: remember to add type hints  # Don't comment TODOs
#
# ==============================================================================
# RULE 18: NO GARBAGE COLLECTION
# ==============================================================================
#
# ✅ DO:
#   # Don't use bare except
#   except SpecificError as e:
#       handle(e)
#
# ❌ DON'T:
#   except:
#       pass  # Catches everything, including KeyboardInterrupt!
#
# ==============================================================================
# RULE 19: TESTING FIRST (OPTIONAL BUT RECOMMENDED)
# ==============================================================================
#
# ✅ DO:
#   # Write test cases first
#   def test_calculate_average():
#       assert calculate_average([10, 20, 30]) == 20
#
#   def calculate_average(scores: list[float]) -> float:
#       """..."""
#
# ==============================================================================
# RULE 20: USE MYTYPE/TYPE CHECKING
# ==============================================================================
#
# ✅ DO:
#   # Run mypy or pyright to catch type errors
#   mypy your_file.py
#
# ❌ DON'T:
#   # Ignore type errors
#
# ==============================================================================
# ==============================================================================
# END OF RULES - FOLLOW ALL 20 RULES!
# ==============================================================================