import asyncio
import logging
from functools import wraps


class SuppressLogging:
    """
    A class for temporarily suppressing logging messages.

    This class can be used as a decorator or a context manager to suppress
    logging messages at a specified level or higher.
    It supports both synchronous and asynchronous functions.

    This can be useful when you want to suppress logging messages temporarily
    in a specific part of your code, such as when running tests
    or when you want to silence noisy loggers.

    Attributes
    ----------
    level : int
        The logging level at which to suppress messages.
        The default is logging.CRITICAL.
    old_level : int
        The previous logging level before the suppression was activated.


    Examples
    --------
    Using as a decorator:

    >>> @SuppressLogging(level=logging.DEBUG)
    ... def my_function():
    ...     logging.debug("This debug message will not be seen")
    ...     print("Function is running")

    Using as a context manager:

    >>> with SuppressLogging(level=logging.INFO):
    ...     logging.info("This info message will not be seen")
    ...     print("Inside context manager")

    Asynchronously using as a decorator:

    >>> @SuppressLogging(level=logging.DEBUG)
    ... async def my_async_function():
    ...     logging.debug("This debug message will not be seen")
    ...     print("Async function is running")

    Asynchronously using as a context manager:

    >>> async with SuppressLogging(level=logging.INFO):
    ...     logging.info("This info message will not be seen")
    ...     print("Inside async context manager")
    """

    def __init__(self, level=logging.CRITICAL):
        """
        Initializes the SuppressLogging object with the specified logging level
        """
        self.level = level
        self.old_level = logging.root.manager.disable

    def __call__(self, func):
        """
        Allows the class instance to be called as a decorator.

        Parameters
        ----------
        func : callable
            The function to which the logging suppression should be applied.
            Can be either a synchronous or asynchronous function.

        Returns
        -------
        callable
            A wrapper function that applies the logging suppression
            to the given function.
        """
        if asyncio.iscoroutinefunction(func):
            @wraps(func)
            async def async_wrapper(*args, **kwargs):
                with self:
                    return await func(*args, **kwargs)
            return async_wrapper
        else:
            @wraps(func)
            def sync_wrapper(*args, **kwargs):
                with self:
                    return func(*args, **kwargs)
            return sync_wrapper

    def __enter__(self):
        """
        Activates logging suppression at the specified level.
        """
        logging.disable(self.level)

    def __exit__(self, exc_type, exc_val, exc_tb):
        """
        Deactivates logging suppression and restores the previous logging level.

        Parameters
        ----------
        exc_type : type
            The exception type, if an exception occurred.
        exc_val : Exception
            The exception instance raised, if an exception occurred.
        exc_tb : traceback
            The traceback object associated with the exception, if an exception occurred.
        """
        logging.disable(self.old_level)

    def __aenter__(self):
        """
        Asynchronously activates logging suppression at the specified level.
        """
        return self.__enter__()

    def __aexit__(self, exc_type, exc_val, exc_tb):
        """
        Asynchronously deactivates logging suppression and restores the previous logging level.
        """
        return self.__exit__(exc_type, exc_val, exc_tb)

    def __repr__(self):
        """
        Returns the machine-readable string representation of the object.
        """
        return f'{self.__class__.__name__}(level={self.level})'

    def __str__(self):
        """
        Returns the human-readable string representation of the object.
        """
        return f"Logging suppression active at level {logging.getLevelName(self.level)}"
