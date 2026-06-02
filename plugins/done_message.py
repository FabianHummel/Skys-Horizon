import logging

from beet import Context

logger = logging.getLogger("pipeline")


def beet_default(ctx: Context):
    yield
    logger.info("Done!")
