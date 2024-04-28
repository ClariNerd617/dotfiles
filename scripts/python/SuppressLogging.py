import asyncio
import logging
from functools import wraps


class SuppressLogging:
    def __init__(self, level=logging.CRITICAL):
        self.level = level
        self.old_level = logging.root.manager.disable

    def __call__(self, func):
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
        logging.disable(self.level)

    def __exit__(self, exc_type, exc_val, exc_tb):
        logging.disable(self.old_level)

    def __aenter__(self):
        return self.__enter__()

    def __aexit__(self, exc_type, exc_val, exc_tb):
        return self.__exit__(exc_type, exc_val, exc_tb)

    def __repr__(self):
        return f'{self.__class__.__name__}(level={self.level})'

    def __str__(self):
        return f"Logging suppression active at level {logging.getLevelName(self.level)}"


# Example usage
if __name__ == '__main__':
    suppress_logging = SuppressLogging(level=logging.DEBUG)
    print(repr(suppress_logging))  # shows the representation of the object
    # shows the string representation of the object
    print(str(suppress_logging))

    # using the class as a decorator
    @suppress_logging
    def my_function():
        logging.debug("This should not be seen")
        return "Function executed"

    print(my_function())

    # Asynchronously using the class as a decorator
    @suppress_logging
    async def my_async_function():
        logging.debug("This should not be seen")
        print("Function executed")

    asyncio.run(my_async_function())

    # Using the class as a context manager
    with SuppressLogging(level=logging.DEBUG):
        logging.debug("This should not be seen")
        print("Inside context manager")

    # Asynchronously using the class as a context manager
    async def my_async_function():
        async with SuppressLogging(level=logging.DEBUG):
            logging.debug("This should not be seen")
            print("Inside context manager")

    asyncio.run(my_async_function())
